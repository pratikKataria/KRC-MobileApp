import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Strings.dart';
import 'package:krc/ui/constructionUpdateScreen/construction_update_screen.dart';
import 'package:krc/ui/contactUsScreen/contact_us_screen.dart';
import 'package:krc/ui/core/login/login_screen.dart';
import 'package:krc/ui/drawer/KitDrawer.dart';
import 'package:krc/ui/home/home_screen.dart';
import 'package:krc/ui/oustandingPaymentScreen/quick_pay_screen.dart';
import 'package:krc/ui/quickPayScreen/quick_pay_screen.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/navigator_gk.dart';
import 'package:krc/utils/scroll_behavior.dart';

import 'res/RouteTransition.dart';
import 'res/Screens.dart';
import 'utils/Utility.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Utility.statusBarAndNavigationBarColor();
  Utility.portrait();

  bool authResult = await (AuthUser.getInstance()).isLoggedIn();

  await Future.delayed(Duration(seconds: 2));
  runApp(MyApp(authResult));
}

class MyApp extends StatelessWidget {
  final bool authResult;

  const MyApp(this.authResult, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.screenBackgroundColor),
      navigatorKey: navigatorGk,
      builder: (_, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "/":
            return RouteTransition(widget: Container());
            break;
          case Screens.kHomeBase:
            return RouteTransition(widget: KitDrawer());
            break;
          default:
            return RouteTransition(widget: LoginScreen());
            break;
        }
      },
      home: ContactUsScreen(),
    );
  }

  checkAuthUser(authResult) {
    if (authResult) {
      return KitDrawer();
    } else {
      return LoginScreen();
    }
  }
}