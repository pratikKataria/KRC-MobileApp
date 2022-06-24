import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/core/core_presenter.dart';
import 'package:krc/ui/core/login/helper/widget/circular_tab_indicator.dart';
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
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin implements LoginView {
  final subTextStyle = textStyleWhite14px600w;
  final mainTextStyle = textStyleWhite12px600w;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  TabController _tabController;
  CorePresenter _corePresenter;
  int emailOtp;
  int mobileOtp;
  int currTabIndex = 0;
  bool checkBox = false;

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
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            verticalSpace(perTop18),
            Image.asset(Images.kLoginImage, width: 200),
            verticalSpace(20),
            buildTabs(),
            verticalSpace(30),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  emailLoginPage(),
                  phoneLoginPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView phoneLoginPage() {
    return ListView(
      children: [
        phoneField(),
        verticalSpace(20.0),
        if (mobileOtp != null) ...[passwordField(), verticalSpace(20.0)],
        loginButton(mobileOtp != null ? "Log In" : "Request OTP"),
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
              text: "Terms and Conditions",
              textStyle: textStyleBlue14px600w,
              color: Colors.transparent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionScreen()));
                // Navigator.pushNamed(context, Screens.kHomeBase);
              },
            ),
          ],
        ),
      ],
    );
  }

  ListView emailLoginPage() {
    return ListView(
      children: [
        emailField(),
        verticalSpace(20.0),
        if (emailOtp != null) ...[
          passwordField(),
          verticalSpace(20.0),
        ],
        PmlButton(
          text: emailOtp != null ? "Log In" : "Request OTP",
          onTap: () {
            if (emailOtp == null) {
              _corePresenter.sendEmailMobileOTP(context, emailTextController.text.toString().trim());
              return;
            }

            String inputText = otpTextController.text.toString();
            if (inputText.isEmpty) {
              onError("Please enter Otp");
              return;
            }

            if (inputText.isEmpty && int.parse(inputText) != emailOtp) {
              onError("Please enter correct otp");
              return;
            }

            if (checkBox == false) {
              onError("Please accept terms and conditions");
              return;
            }

            _corePresenter.emailLogin(context, emailTextController.text.toString().trim());

            // Navigator.pushNamed(context, Screens.kHomeBase);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionScreen()));
          },
        ),
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
              text: "Terms and Conditions",
              textStyle: textStyleBlue14px600w,
              color: Colors.transparent,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionScreen()));
                // Navigator.pushNamed(context, Screens.kHomeBase);
              },
            ),
          ],
        ),
      ],
    );
  }

  TabBar buildTabs() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.transparent,
      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
      unselectedLabelStyle: textStyleDark14px500w,
      unselectedLabelColor: AppColors.textColorBlack,
      indicator: CircleTabIndicator(color: AppColors.white, radius: 3),
      labelColor: AppColors.textColorGreen,
      onTap: (int index) {
        if (currTabIndex != _tabController.index) print("update");
        currTabIndex = _tabController.index;
        setState(() {});
      },
      tabs: [
        Tab(
          child: PmlButtonV2(
            text: "Email",
            height: 28.0,
            textStyle: textStyleWhite14px600w,
            color: AppColors.transparent,
          ),
        ),
        Tab(
          child: PmlButtonV2(
            text: "Phone",
            height: 28.0,
            textStyle: textStyleWhite14px600w,
            color: AppColors.transparent,
          ),
        ),
      ],
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
            child: Text("Phone", style: mainTextStyle),
          ),
          Expanded(
            child: TextFormField(
              obscureText: false,
              textAlign: TextAlign.left,
              controller: phoneTextController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter phone number",
                hintStyle: subTextStyle,
                suffixStyle: TextStyle(color: AppColors.textColor),
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
  onError(String message) {
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
    var currentUser = await AuthUser.getInstance().getCurrentUser();
    currentUser.userCredentials = emailResponse;
    AuthUser.getInstance().login(currentUser);

    Navigator.pop(context);
    Navigator.pushNamed(context, Screens.kHomeBase);
  }
}
