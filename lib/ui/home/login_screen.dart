import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/user/token_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final subTextStyle = textStyleWhite14px600w;
  final mainTextStyle = textStyleSubText14px700w;

  final TextEditingController emailTextController = TextEditingController();

  final TextEditingController otpTextController = TextEditingController();

  BuildContext _context;
  int otp;
  TokenResponse _tokenResponse;
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    // 18% from top
    _context = context;
    final perTop18 = Utility.screenHeight(context) * 0.12;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(perTop18),
              Image.asset(Images.kLoginImage, width: 200),
              verticalSpace(perTop18),
              emailField(),
              verticalSpace(20.0),
              if (otp != null) passwordField(),
              loginButton(otp != null ? "Log In" : "Request OTP"),
              verticalSpace(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: checkBox,
                    onChanged: (val) {
                      checkBox = val;
                      setState(() {});
                    },
                  ),
                  PmlButton(
                    height: 20,
                    text: "Terms and Condition",
                    textStyle: textStyleBlue16px500w,
                    color: Colors.transparent,
                    onTap: () {
                      // Navigator.pushNamed(context, Screens.kHomeBase);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container emailField() {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        // borderRadius: BorderRadius.circular(6.0),
      ),
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
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
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
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
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
              inputFormatters: [LengthLimitingTextInputFormatter(4)],
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
        // Navigator.pushNamed(context, Screens.kHomeBase);
      },
    );
  }
}
