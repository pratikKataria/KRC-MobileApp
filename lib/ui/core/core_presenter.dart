import 'dart:math';

import 'package:krc/ui/api/api_controller_expo.dart';
import 'package:krc/ui/api/api_end_points.dart';
import 'package:krc/ui/api/api_error_parser.dart';
import 'package:krc/ui/base/base_presenter.dart';
import 'package:krc/ui/core/core_view.dart';
import 'package:krc/ui/core/login/helper/model/otp_response.dart';
import 'package:krc/ui/core/login/login_view.dart';
import 'package:krc/user/AuthUser.dart';
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
