import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/user/token_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/pml_button.dart';

class TermsAndConditionScreen extends StatefulWidget {
  TermsAndConditionScreen({Key key}) : super(key: key);

  @override
  _TermsAndConditionScreenState createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
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
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Header("Terms and Condition"),
              verticalSpace(20.0),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Text("""Introduction
These Website Standard Terms and Conditions written on this webpage shall manage your use of our website, Webiste Name accessible at Website.com.

These Terms will be applied fully and affect to your use of this Website. By using this Website, you agreed to accept all terms and conditions written in here. You must not use this Website if you disagree with any of these Website Standard Terms and Conditions.

Minors or people below 18 years old are not allowed to use this Website.

Intellectual Property Rights
Other than the content you own, under these Terms, Company Name and/or its licensors own all the intellectual property rights and materials contained in this Website.

You are granted limited license only for purposes of viewing the material contained on this Website.

Restrictions
You are specifically restricted from all of the following:

publishing any Website material in any other media;
selling, sublicensing and/or otherwise commercializing any Website material;
publicly performing and/or showing any Website material;
using this Website in any way that is or may be damaging to this Website;
using this Website in any way that impacts user access to this Website;
using this Website contrary to applicable laws and regulations, or in any way may cause harm to the Website, or to any person or business entity;
engaging in any data mining, data harvesting, data extracting or any other similar activity in relation to this Website;
using this Website to engage in any advertising or marketing.
Certain areas of this Website are restricted from being access by you and Company Name may further restrict access by you to any areas of this Website, at any time, in absolute discretion. Any user ID and password you may have for this Website are confidential and you must maintain confidentiality as well.

Your Content
In these Website Standard Terms and Conditions, “Your Content” shall mean any audio, video text, images or other material you choose to display on this Website. By displaying Your Content, you grant Company Name a non-exclusive, worldwide irrevocable, sub licensable license to use, reproduce, adapt, publish, translate and distribute it in any and all media.

Your Content must be your own and must not be invading any third-party’s rights. Company Name reserves the right to remove any of Your Content from this Website at any time without notice. """,
                        style: textStyleWhite16px600w),
                  ),
                ),
              ),
              /*verticalSpace(perTop18),
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
              ),*/
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
