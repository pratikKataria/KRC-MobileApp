import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/res/Screens.dart';

/// 🔥 MVP Architecture🔥
/// 🍴 Focused on Clean Architecture
/// Created by 🔱 Pratik Kataria 🔱 on 12-08-2021.
class RouteTransition extends PageRouteBuilder {
  final Widget? widget;

  RouteTransition({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return WillPopScope(
                onWillPop: () {


                  if (headerTextController.value == Screens.kQuickPayScreen ||
                      headerTextController.value == Screens.kTicketsScreen ||
                      headerTextController.value == Screens.kNotificationScreen ||
                      headerTextController.value == Screens.kContactUsScreen) {

                    headerTextController.value = Screens.kHomeScreen;
                    return Future<bool>.value(false);
                  }

                  if (headerTextController.value != Screens.kCreateTicketsScreen) {
                    headerTextController.value = Screens.kHomeScreen;
                  }

                  return Future<bool>.value(true);
                },
                child: widget!);
          },
          transitionDuration: Duration(milliseconds: 800),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              fillColor: Theme.of(context).cardColor,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },

          /*   transitionsBuilder: (BuildContext context, Animation<double>animation,
          Animation<double>secondaryAnimation, Widget child) {
        return new SlideTransition(position: new Tween<Offset>(

          begin: const Offset(0.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
          child: child,);
      }*/
        );
}
