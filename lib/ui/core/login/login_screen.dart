import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/core/core_presenter.dart';
import 'package:krc/ui/core/login/login_view.dart';
import 'package:krc/ui/core/termsAndCondition/terms_and_condition_screen.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/user/CurrentUser.dart';
import 'package:krc/user/login_response.dart';
import 'package:krc/user/token_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:krc/widgets/pml_button_v2.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin implements LoginView {
  final subTextStyle = textStyleWhite14px600w;
  final mainTextStyle = textStyleWhite12px600w;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  TabController? _tabController;
  late CorePresenter _corePresenter;
  int? emailOtp;
  int? mobileOtp;
  int currTabIndex = 0;
  bool? checkBox = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _corePresenter = CorePresenter(this);
    _corePresenter.getAccessToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 18% from top

    final perTop18 = Utility.screenHeight(context) * 0.12;
    return Scaffold(
      body: Container(
        width: Utility.screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Assets.imagesImgLoginBg), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(perTop18),


            Spacer(),
            Text("Welcome To", style: textStyleWhite32px600wF2),
            Text("K Raheja Corp", style: textStyleWhite32px600wF2),

            verticalSpace(50.0),
            Text("Email/Mobile", style: textStyleWhite12px500w),
            verticalSpace(8.0),
            phoneField(),
            verticalSpace(20.0),
            if (mobileOtp != null) ...[passwordField(), verticalSpace(20.0)],
            loginButton(mobileOtp != null ? "Log In" : "Request OTP"),
            verticalSpace(90.0),
            PmlButton(
              height: 20,
              text: "Terms and Conditions",
              textStyle: textStyleWhite16px700w,
              color: Colors.transparent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionScreen()));
                // Navigator.pushNamed(context, Screens.kHomeBase);
              },
            ),
            verticalSpace(20.0),
          ],
        ),
      ),
    );
  }

  Container emailField() {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: AppColors.inputFieldBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Email", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: emailTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter email address",
                hintStyle: subTextStyle,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                emailOtp = null;
                otpTextController.clear();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Container phoneField() {
    return Container(
      height: 45,
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          horizontalSpace(10.0),
          Icon(Icons.phone_android_sharp, color: Colors.grey),
          horizontalSpace(10.0),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: phoneTextController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: textStyle14px500w,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter email id / mobile number",
                hintStyle: textStyle14px500w,
                suffixStyle: textStyle14px500w,
                isDense: true,
              ),
              onChanged: (String val) {
                mobileOtp = null;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Container passwordField() {
    return Container(
      height: 38,
      decoration: BoxDecoration(color: AppColors.inputFieldBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65,
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("OTP", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              // obscureText: true,
              textAlign: TextAlign.left,
              controller: otpTextController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                FilteringTextInputFormatter.digitsOnly,
              ],
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter password",
                hintStyle: subTextStyle,
                suffixStyle: TextStyle(color: AppColors.textColor),
              ),
              onChanged: (String val) {
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
              },
            ),
          ),
        ],
      ),
    );
  }

  PmlButton loginButton(String text) {
    return PmlButton(
      text: "$text",
      onTap: () {
        if (mobileOtp == null) {
          _corePresenter.sendEmailMobileOTP(context, phoneTextController.text.toString());
          return;
        }

        String inputText = otpTextController.text.toString();
        if (inputText.isEmpty) {
          onError("Please enter Otp");
          return;
        }

        if (int.parse(inputText) != mobileOtp) {
          onError("Please enter correct otp");
          return;
        }

        if (checkBox == false) {
          onError("Please accept terms and conditions");
          return;
        }

        _corePresenter.mobileLogin(context, phoneTextController.text.toString());

        // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionScreen()));
        // Navigator.pushNamed(context, Screens.kHomeBase);
      },
    );
  }

  @override
  onError(String? message) {
    Utility.showErrorToastC(context, message);
  }

  @override
  void onTokenGenerated(TokenResponse tokenResponse) {
    //Save token
    var currentUser = CurrentUser()..tokenResponse = tokenResponse;
    AuthUser.getInstance().saveToken(currentUser);

    // //sent otp request
    // CorePresenter presenter = CorePresenter(this);
    // presenter.sendEmailMobileOTP(emailTextController.text.toString());
  }

  @override
  void onOtpSent(int otp, int emailOrMobile) {
    otpTextController.clear();
    Utility.showSuccessToastB(context, "Otp sent successfully");
    if (emailOrMobile == 0) {
      this.emailOtp = otp;
    } else {
      this.mobileOtp = otp;
    }
    setState(() {});
  }

  @override
  void onEmailVerificationSuccess(LoginResponse emailResponse) async {
    //Save userId
    var currentUser = await (AuthUser.getInstance().getCurrentUser() as FutureOr<CurrentUser>);
    currentUser.userCredentials = emailResponse;
    AuthUser.getInstance().login(currentUser);

    Navigator.pop(context);
    Navigator.pushNamed(context, Screens.kHomeBase);
  }
}
