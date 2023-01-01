import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/Ticket/ticket_screen.dart';
import 'package:krc/ui/bottomNavigation/home/model/rm_detail_response.dart';
 import 'package:krc/ui/notificationScreen/notification_screen.dart';
import 'package:krc/ui/quickPayScreen/quick_pay_screen.dart';
import 'package:krc/ui/rmDetail/contact_us_screen.dart';

import 'home/home_screen.dart';

class BottomNavigationBaseScreen extends StatelessWidget {
  // final GlobalKey<NotificationScreenState> nGK = GlobalKey<NotificationScreenState>();
  // final GlobalKey<HomeScreenState> hGK = GlobalKey<HomeScreenState>();
  late Map<String, Widget> allDestinations;

  BottomNavigationBaseScreen() {
    initState();
  }

  void initState() async {
    allDestinations = {
      Screens.kHomeScreen: HomeScreen(),
      Screens.kQuickPayScreen: QuickPayScreen(),
      Screens.kTicketsScreen: TicketScreen(),
      Screens.kContactUsScreen: ContactUsScreen(),
      Screens.kNotificationScreen: NotificationScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: headerTextController,
        builder: (context, value, _) {
          return IndexedStack(
            index: getIndexOfScreen(value),
            children: allDestinations.values.toList(),
          );
        });
  }

  int getIndexOfScreen(String screen) {
    switch (screen) {
      case Screens.kHomeScreen:
        return 0;
      case Screens.kQuickPayScreen:
        return 1;
      case Screens.kTicketsScreen:
        return 2;
      case Screens.kContactUsScreen:
        return 3;
      case Screens.kNotificationScreen:
        return 4;
      default:
        return 0;
    }
  }
}
