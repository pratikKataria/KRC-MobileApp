import 'package:flutter/material.dart';
import 'package:krc/controller/header_text_controller.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Screens.dart';
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
          return Container(child: (headerTextController.value == Screens.kHomeScreen) ? headerHome() : headerOther(context));
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
              height: 24.0,
              width: 24.0,
              color: AppColors.white,
              padding: EdgeInsets.only(top: 5.0),
              child: Image.asset(Assets.imagesIcMenu, width: 24.0, height: 24.0),
              onTap: () {
                // drawerGlobalKey.currentState!.openDrawer();
                // BaseProvider provider = Provider.of(context, listen: false);
                // provider.open();

                // print('is opened ${provider.isOpen}');
                // if (!provider.isOpen) {
                //   provider.open();
                //   menuAnimController.forward();
                // } else {
                //   provider.close();
                //   menuAnimController.reverse();
                // }
              }),
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
              Navigator.pop(context);
            },
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
          Spacer(),
          Text("$heading", style: textStyle14px500w),
        ],
      ),
    );
  }
}
