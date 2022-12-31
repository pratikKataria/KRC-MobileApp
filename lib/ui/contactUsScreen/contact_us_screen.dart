import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.imagesIcHeadquaterImage), fit: BoxFit.fill),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                cardViewBankDetail(),
                verticalSpace(40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container cardViewBankDetail() {
    return Container(
      height: 290,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 14.0, blurRadius: 10.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          unitColumn(),
          nameColumn(),
          Text(
            "We are available from Monday to Friday between 10:30AM to 6:30PM",
            style: textStyleSubText14px500w,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Column unitColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Raheja Sterling", style: textStyle14px600w),
        Row(
          children: [
            Text("Unit Number: IB903", style: textStyle14px500w),
            horizontalSpace(20.0),
            Container(height: 6.0, width: 6.0, color: AppColors.colorPrimary),
            horizontalSpace(20.0),
            Text("Tower: IB", style: textStyle14px500w),
          ],
        ),
      ],
    );
  }

  Column nameColumn() {
    return Column(
      children: [
        line(),
        verticalSpace(12.0),
        Row(
          children: [
            Container(height: 34.0, width: 34.0, child: Placeholder()),
            horizontalSpace(20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ms. Shalini Patel", style: textStyle14px500w),
                Text("shalini.patel@stetig.com", style: textStyle14px500w),
              ],
            ),
          ],
        ),
        verticalSpace(8.0),
        Row(
          children: [
            horizontalSpace(54.0),
            Image.asset(Assets.imagesIcCall, height: 40.0),
            horizontalSpace(12.0),
            Image.asset(Assets.imagesIcMessage, height: 40.0),
            horizontalSpace(12.0),
            Image.asset(Assets.imagesIcWhatsApp, height: 40.0),
            horizontalSpace(12.0),
            Image.asset(Assets.imagesIcMail, height: 40.0),
          ],
        ),
        verticalSpace(12.0),
        line(),
      ],
    );
  }

}
