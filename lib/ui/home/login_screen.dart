import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/user/token_response.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:krc/widgets/pml_button_v2.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final subTextStyle = textStyleWhite14px600w;
  final mainTextStyle = textStyleSubText14px700w;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController otpTextController = TextEditingController();

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

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
                  ListView(
                    children: [
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
                  ListView(
                    children: [
                      phoneField(),
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
                ],
              ),
            ),
          ],
        ),
      ),
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
        setState(() {});
      },
      tabs: [
        Tab(
            child: PmlButtonV2(
          text: "Email",
          height: 28.0,
          textStyle: textStyleWhite14px600w,
          color: AppColors.transparent,
          onTap: () {
            // currentSelectedTab = "Walk in";
            _tabController.index = 0;
            setState(() {});
          },
        )),
        Tab(
            child: PmlButtonV2(
          text: "Phone",
          height: 28.0,
          textStyle: textStyleWhite14px600w,
          color: AppColors.transparent,
          onTap: () {
            // currentSelectedTab = "Walk in";
            _tabController.index = 0;
            setState(() {});
          },
        )),
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
                /*      widget.onTextChange(val);
                        resetErrorOnTyping();*/
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
              controller: emailTextController,
              maxLines: 1,
              textCapitalization: TextCapitalization.none,
              style: subTextStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter phone number",
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

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius}) : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset + Offset(cfg.size.width / 2, cfg.size.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
