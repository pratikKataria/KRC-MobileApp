import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/controller/navigator_controller.dart';
import 'package:krc/controller/side_navigation_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/utils/Dialogs.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';

class Header extends StatelessWidget {
  final String heading;

  const Header(this.heading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      color: AppColors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ValueListenableBuilder<String>(
        valueListenable: headerTextController,
        builder: (context, value, _) {
          return Container(
              child: (headerTextController.value == Screens.kHomeScreen) ||
                      (headerTextController.value == Screens.kQuickPayScreen) ||
                      (headerTextController.value == Screens.kTicketsScreen) ||
                      (headerTextController.value == Screens.kContactUsScreen) ||
                      (headerTextController.value == Screens.kNotificationScreen)
                  ? headerHome()
                  : headerOther(context));
        },
      ),
    );
  }

  Container headerHome() {
    // var baseProvider = Provider.of<BaseProvider>(context);
    return Container(
      color: AppColors.white,
      height: 50,
      child: Row(
        children: [
          PmlButton(
              height: 50.0,
              width: 24.0,
              color: AppColors.white,
              padding: EdgeInsets.only(top: 5.0),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(Assets.imagesIcMenu),
              ),
              onTap: () => sideNavigationController.currentState!.openDrawer()),
          Spacer(),
          Image.asset(Assets.imagesIcKRahejaCrop, height: 24.0),
          Spacer(),
        ],
      ),
    );
  }

  Container headerOther(BuildContext context) {
    // var baseProvider = Provider.of<BaseProvider>(context);
    return Container(
      color: AppColors.white,
      height: 50,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              bool progressBarIsVisible = Dialogs.dialog?.isShowing() ?? false;

              if (progressBarIsVisible) {
                navigatorController.currentState?.pop();
              } else {
                if (headerTextController.value != Screens.kTicketsScreen) headerTextController.value = Screens.kHomeScreen;
                navigatorController.currentState?.pop();
              }
            },
            child: Container(
              height: 50.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, size: 20.0),
                  horizontalSpace(10.0),
                  Text("Back", style: textStyle14px500w),
                ],
              ),
            ),
          ),
          Spacer(),
          Text(headerTextController.value, style: textStyle14px500w),
        ],
      ),
    );
  }
}
