import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';

class PersistentBottomNavigation extends StatelessWidget {
  const PersistentBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildBottomNavigationButton(Assets.imagesIcBtmHome, "Home", () {}, context),
          buildBottomNavigationButton(Assets.imagesIcBtmQuickPay, "Quick Pay", () {}, context),
          buildBottomNavigationButton(Assets.imagesIcBtmServiceTicket, "Tickets", () {}, context),
          buildBottomNavigationButton(Assets.imagesIcBtmContactUs, "Explore", () {}, context),
          buildBottomNavigationButton(Assets.imagesIcBtmProject, "Notifications", () {}, context),
          // buildBottomNavigationButton(Images.kIconLeaderboard, "Leaderboard", () {}),
        ],
      ),
    );
  }

  InkWell buildBottomNavigationButton(String icon, String text, Function() onTap, BuildContext context) {
    return InkWell(
      onTap: () {
        // provider.setBottomNavScreen(text);
        // navigateToFirstRoute(context);
        // onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 20.0, height: 20.0),
          verticalSpace(4.0),
          Text("$text", style: textStyle12px500w, textAlign: TextAlign.center),
        ],
      ),
    );
  }

/* void navigateToFirstRoute(BuildContext context) {
    navigatorGk.currentState.popUntil((route) => route.isFirst);

    //clear screen backstack
    BaseProvider baseProvider = Provider.of<BaseProvider>(context, listen: false);
    baseProvider.screenStack.popAll();
  }*/
}
