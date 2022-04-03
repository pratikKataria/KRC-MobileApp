import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController menuAnimController;

  @override
  void initState() {
    super.initState();
    menuAnimController = AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          header(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(20.0),
                Row(
                  children: [
                    Image.asset(Images.kCircleRight, width: 50.0, height: 30.0),
                    Spacer(),
                    Text("Nova at Raheja Viva", style: textStyleWhite16px600w),
                    Spacer(),
                    Image.asset(Images.kCircleLeft, width: 50.0, height: 30.0),
                  ],
                ),
                verticalSpace(20.0),
                Text("Nova at Raheja Viva", style: textStyleWhite16px600w),
                verticalSpace(10.0),
                Text("""Apartments in West Pune | New Launch in West Pune – Raheja 
Nova Nestled amid the magnificent Sahyadri 60+ species of birds flock 
together here. Let’s take a glance 
at a few of its most impressive 
features:

Better AQI Index – The air here is 
94% cleaner* as compared to other city pockets. What more can a fitness enthusiast wish for?3 degree^ cooler temperatureLow decibel levels – With 47% less noise* than the permissible limits, Nova at Raheja Viva is the perfect place to relish rendezvous with your soul and 
discover the bliss of solitude.""", style: textStyleWhite14px500w),
              ],
            ),
          ),
          verticalSpace(20.0),
          Image.asset(Images.kPH2),
        ],
      ),
    );
  }

  Container header() {
    var baseProvider = Provider.of<BaseProvider>(context);
    return Container(
      height: 50,
      decoration: BoxDecoration(color: AppColors.inputFieldBackgroundColor, boxShadow: [
        BoxShadow(
          color: AppColors.inputFieldBackgroundColor,
          spreadRadius: 2,
          offset: Offset(1, 1),
          blurRadius: 1.5,
        )
      ]),
      child: Row(
        children: [
          horizontalSpace(20.0),
          PmlButton(
              height: 34.0,
              width: 34.0,
              color: AppColors.transparent,
              padding: EdgeInsets.only(top: 5.0),
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_arrow,
                color: AppColors.white,
                progress: menuAnimController,
              ) /* Image.asset(Images.kMenu, width: 24.0, height: 24.0)*/,
              onTap: () {
                print('is opened ${baseProvider.isOpen}');
                if (!baseProvider.isOpen) {
                  baseProvider.open();
                  menuAnimController.forward();
                } else {
                  baseProvider.close();
                  menuAnimController.reverse();
                }
              }),
          horizontalSpace(10.0),
          Spacer(),
          Image.asset(Images.kAppIcon, width: 50.0, height: 30.0),
          // KitButton(child: Image.asset(Images.kNotification, width: 24.0, height: 24.0, color: AppColors.lineColorGrey)),
          horizontalSpace(20.0),
          // KitButton(
          //     child: Image.asset(Images.kSearch, width: 24.0, height: 24.0),
          //     onTap: () => Navigator.pushNamed(context, Screens.kSearchScreen)),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (builder) {
          return Container(
            height: Utility.screenHeight(context) * 0.45,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                )),
          );
        });
  }
}
