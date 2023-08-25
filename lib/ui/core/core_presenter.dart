import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:krc/common_imports.dart';
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

  void sendEmailMobileOTP(BuildContext context, String value) async {
    //check for internal token
    // if (await AuthUser.getInstance().hasToken()) {
    //   _v.onError("Token not found");
    //   return;
    // }

    //check network
    if (!await NetworkCheck.check()) return;

    if (value.isEmpty) {
      _v.onError("Please enter email or phone");
      return;
    }

    //if incoming value is mobile number
    if (checkForMobileNumber(value)) {
      if (value.length == 10)
        sendMobileOTP(context, value);
      else
        _v.onError("please enter valid mobile number");
      return;
    }

    int mobileOtp = _genRandomNumber();
    var body = {
      "Email": "$value",
      "GenOTP": "$mobileOtp",
    };

    Dialogs.showLoader(context, "Sending otp ...");
    apiController.post(EndPoints.SEND_EMAIL_OTP, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader();
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
        Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  void sendMobileOTP(BuildContext context, String mobileNo) async {
    //check for internal token

    //check network
    if (!await NetworkCheck.check()) return;

    int mobileOtp = _genRandomNumber();

    String api =
        "https://sms6.rmlconnect.net:8443/OtpApi/otpgenerate?username=KRahejaTR&password=9%5BjYi8E_&msisdn=918717805155&msg=Dear+Customer%2C+%0D%0A%0D%0APlease+use+the+OTP+%25m+to+login+to+our+mobile+app.+Kindly+do+not+share+with+others.%0D%0A%0D%0ABest+Regards%2C%0D%0AK+Raheja+Corp&source=KRCORP&otplen=6&exptime=30&entityid=1201159982989525299&tempid=1607100000000270540";
    Dialogs.showLoader(context, "Sending mobile OTP ...");
    apiController.get(api, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader();
        Utility.log(tag, response.data);

        LoginView loginView = _v as LoginView;
        loginView.onOtpSent(mobileOtp, 1);
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  void getTermsAndConditions(BuildContext context) async {
    //check for internal token

    //check network
    if (!await NetworkCheck.check()) return;

    Dialogs.showLoader(context, "Getting Terms And Conditions");
    apiController.post("${EndPoints.GET_TERMS_CONDITIONS}", headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader();
        TermsAndConditionResponse termsAndConditionResponse = TermsAndConditionResponse.fromJson(response.data);
        TermsAndConditionView view = _v as TermsAndConditionView;

        if (termsAndConditionResponse.returnCode!) {
          view.onTermsAndConditionFetched(termsAndConditionResponse);
        } else {
          view.onError(termsAndConditionResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  void emailLogin(BuildContext context, String email) async {
    //check for internal token

    //check network
    if (!await NetworkCheck.check()) return;

    var body = {
      "Email": email,
      "TermsConditionAccepted": true,
    };

    Dialogs.showLoader(context, "Verifying email ...");
    apiController.post(EndPoints.VERIFY_EMAIL_OTP, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader();
        Utility.log(tag, response.data);
        LoginResponse emailResponse = LoginResponse.fromJson(response.data);
        LoginView loginView = _v as LoginView;

        if (emailResponse.returnCode!) {
          loginView.onEmailVerificationSuccess(emailResponse);
        } else {
          loginView.onError(emailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  void verifyLogin(BuildContext context, String mobileOrEmailString, String otp) {
    //if incoming value is mobile number
    if (checkForMobileNumber(mobileOrEmailString)) {
      if (mobileOrEmailString.length == 10) {
        verifyMobileOtp(context, mobileOrEmailString, otp);
      } else {
        _v.onError("please enter valid mobile number");
      }
      return;
    } else {
      emailLogin(context, mobileOrEmailString);
    }
  }

  void mobileLogin(BuildContext context, String mobile) async {
    //check for internal token

    //check network
    if (!await NetworkCheck.check()) return;

    var body = {"MobileNumber": mobile, "TermsConditionAccepted": true};

    Dialogs.showLoader(context, "Logging in ...");
    apiController.post(EndPoints.VERIFY_MOBILE, body: body, headers: await Utility.header())
      ..then((response) {
        Dialogs.hideLoader();
        Utility.log(tag, response.data);
        LoginResponse emailResponse = LoginResponse.fromJson(response.data);
        LoginView loginView = _v as LoginView;

        if (emailResponse.returnCode!) {
          loginView.onEmailVerificationSuccess(emailResponse);
        } else {
          loginView.onError(emailResponse.message);
        }
        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  void verifyMobileOtp(BuildContext context, String mobile, String otp) async {
    Dialogs.showLoader(context, "Verifying mobile OTP ...");
    apiController.get("https://sms6.rmlconnect.net:8443/OtpApi/checkotp?username=KRahejaTR&password=9%5BjYi8E_&msisdn=91$mobile&otp=$otp")
      ..then((response) {
        Dialogs.hideLoader();
        Utility.log(tag, response.data);
        String message = _getResponseMessage(response.data);

        if (response.data == "101") {
          mobileLogin(context, mobile);
          return;
        }

        _v.onError(message);

        return;
      })
      ..catchError((e) {
        Dialogs.hideLoader();
        ApiErrorParser.getResult(e, _v);
      });
  }

  static bool checkForMobileNumber(String val) {
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

  String _getResponseMessage(String responseBody) {
    switch (responseBody) {
      case '101':
        return 'OTP validated successfully.';
      case '102':
        return 'OTP has expired.';
      case '103':
        return 'Entry for OTP not found.';
      case '104':
        return 'MSISDN not found.';
      case '1702':
        return 'One of the parameter missing or OTP is not numeric.';
      case '1703':
        return 'Authentication failed.';
      case '1706':
        return 'Given destination is invalid.';
      default:
        return 'Unknown response: $responseBody';
    }
  }
}
