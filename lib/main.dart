import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/controller/navigator_controller.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Strings.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/bottomNavigation/bottom_navigation_base_screen.dart';
import 'package:krc/ui/constructionImages/construction_images_screen.dart';
import 'package:krc/ui/core/login/login_screen.dart';
import 'package:krc/ui/document/document_screen.dart';
import 'package:krc/ui/notificationScreen/notification_screen.dart';
import 'package:krc/ui/oustandingPaymentScreen/outstanding_payment_screen.dart';
import 'package:krc/ui/quickPayScreen/quick_pay_screen.dart';
import 'package:krc/ui/rmDetail/contact_us_screen.dart';
import 'package:krc/user/AuthUser.dart';
import 'package:krc/utils/scroll_behavior.dart';

import 'res/RouteTransition.dart';
import 'res/Screens.dart';
import 'ui/base/BaseWidget.dart';
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
      theme: ThemeData(primarySwatch: AppColors.primaryColorShades ,scaffoldBackgroundColor: AppColors.screenBackgroundColor),
      navigatorKey: navigatorController,
      builder: (_, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          // child: child!,
          child: BaseWidget(child: child!),
        );
      },
      onGenerateRoute: (RouteSettings settings) {
        headerTextController.value = settings.name!;

        switch (settings.name) {
          case "/":
            return RouteTransition(widget: Container());
          case Screens.kHomeScreen:
            return RouteTransition(widget: BottomNavigationBaseScreen());
          case Screens.kQuickPayScreen:
            return RouteTransition(widget: QuickPayScreen());
          case Screens.kTicketsScreen:
            return RouteTransition(widget: TicketScreen());
          case Screens.kContactUsScreen:
            return RouteTransition(widget: ContactUsScreen());
          case Screens.kNotificationScreen:
            return RouteTransition(widget: NotificationScreen());
          case Screens.kContactUsScreen:
            return RouteTransition(widget: ContactUsScreen());
          case Screens.kDocumentScreen:
            return RouteTransition(widget: DocumentScreen());
          case Screens.kConstructionUpdateScreen:
            return RouteTransition(widget: ConstructionImagesScreen());
          case Screens.kOutstandingPayment:
            return RouteTransition(widget: OutstandingPaymentsScreen());
          default:
            return RouteTransition(widget: LoginScreen());
        }
      },
      home: checkAuthUser(authResult),
    );
  }

  checkAuthUser(authResult) {
    if (authResult) {
      return BottomNavigationBaseScreen();
    } else {
      return LoginScreen();
    }
  }
}