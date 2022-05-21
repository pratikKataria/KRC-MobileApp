import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:krc/ui/api/api_controller_expo.dart';
import 'package:krc/ui/api/api_end_points.dart';
import 'package:krc/ui/api/api_error_parser.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/core/core_view.dart';
import 'package:krc/ui/core/login/helper/model/otp_response.dart';
import 'package:krc/ui/core/login/login_view.dart';
import 'package:krc/ui/core/termsAndCondition/model/terms_and_condition_response.dart';
import 'package:krc/ui/core/termsAndCondition/terms_and_condition_view.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/login_response.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/NetworkCheck.dart';
import 'package:krc/utils/Utility.dart';

class CorePresenter extends BasePresenter {
  CoreView _v;

  CorePresenter(this._v) : super(_v);

  void sendEmailMobileOTP(String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    if (value.isEmpty) {
      _v.onError("Please enter email or phone");
      return;
    }

    //if incoming value is mobile number
    if (checkForMobileNumber(value)) {
      if (value.length == 10)
        sendMobileOTP(value);
      else
        _v.onError("please enter valid mobile number");
      return;
    }

    int mobileOtp = _genRandomNumber();
    var body = {
      "Email": "$value",
      "GenOTP": "$mobileOtp",
    };

    apiController.post(EndPoints.SEND_EMAIL_OTP, body: body, headers: await Utility.header())
      ..then((response) {
        OTPResponse otpResponse = OTPResponse.fromJson(response.data);
        if (otpResponse.returnCode == false) {
          _v.onError(otpResponse.message);
          return;
        }

        if (_v is LoginView) {
          LoginView loginView = _v as LoginView;
          loginView.onOtpSent(mobileOtp, 0);
          return;
        }
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void sendMobileOTP(String value) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    int mobileOtp = _genRandomNumber();

    String queryParams =
        "username=7506775158&password=Stetig@123&To=$value&senderid=VM-PRLCRM&feedid=372501&Text=Your%20OTP%20for%20MyPiramal%20App%20is%20$mobileOtp%20kindly%20use%20this%20for%20login";
    apiController.get("${EndPoints.SEND_EMAIL_OTP}$queryParams", headers: await Utility.header())
      ..then((response) {
        Utility.log(tag, response.data);

        LoginView loginView = _v as LoginView;
        loginView.onOtpSent(mobileOtp, 1);
        return;
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTermsAndConditions(BuildContext context) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    Dialogs.showLoader(context, "Getting Terms And Conditions");
    apiController.post("${EndPoints.GET_TERMS_CONDITIONS}", headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader(context);
        TermsAndConditionResponse termsAndConditionResponse = TermsAndConditionResponse.fromJson(response.data);
        TermsAndConditionView view = _v as TermsAndConditionView;

        if (termsAndConditionResponse.returnCode) {
          view.onTermsAndConditionFetched(termsAndConditionResponse);
        } else {
          view.onError(termsAndConditionResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader(context);
        ApiErrorParser.getResult(e, _v);
      });
  }

  void emailLogin(String email) async {
    //check for internal token
    if (await AuthUser.getInstance().hasToken()) {
      _v.onError("Token not found");
      return;
    }

    //check network
    if (!await NetworkCheck.check()) return;

    var body = {
      "Email": email,
      "TermsConditionAccepted": true,
    };

    apiController.post(EndPoints.VERIFY_EMAIL_OTP, body: body, headers: await Utility.header())
      ..then((response) {
        Utility.log(tag, response.data);
        LoginResponse emailResponse = LoginResponse.fromJson(response.data);
        LoginView loginView = _v as LoginView;

        if (emailResponse.returnCode) {
          loginView.onEmailVerificationSuccess(emailResponse);
        } else {
          loginView.onError(emailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        ApiErrorParser.getResult(e, _v);
      });
  }

  bool checkForMobileNumber(String val) {
    try {
      int.parse(val);
      return true;
    } catch (numberFormatException) {
      return false;
    }
  }

  int _genRandomNumber() {
    var rng = new Random();
    var code = rng.nextInt(900) + 1000;
    Utility.log(tag, code);
    return code;
  }
}
