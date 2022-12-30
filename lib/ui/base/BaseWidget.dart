import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/persistent_bottom_navigation.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  final String label;

  const BaseWidget({required this.child, this.label = "non", Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: drawerKey,
        // endDrawer: PersistentSideNavigation(),
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        body: Column(
          children: [
            ValueListenableBuilder<String>(
              valueListenable: headerTextController,
              builder: (context, value, _) {
                return  Header("heading");
              },
            ),
            line(),
            verticalSpace(4.0),

            /* ValueListenableBuilder<bool>(
              valueListenable: toolbarController,
              builder: (context, value, _) {
                return Container(child: value ? Container() : Header("heading"));
              },
          ),*/
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: child,
              ),
            ),
            line(),
            PersistentBottomNavigation(),
          ],
        ),
      ),
    );
  }
}
