import 'package:flutter/material.dart';
import 'package:krc/generated/assets.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';

class QuickPayScreen extends StatelessWidget {
  const QuickPayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              cardViewBankDetail("Principle Account", "Krc Homes Officials", "2455 8899 1002 1121", "SBIN2341"),
              verticalSpace(36.0),
              line(),
              verticalSpace(36.0),
              cardViewBankDetail("GST Account", "Krc Homes Officials", "2455 8899 1002 1121", "SBIN2341"),
              verticalSpace(36.0),
              line(),
              verticalSpace(36.0),
              cardViewBankDetail("Other Charges Account", "Krc Homes Officials", "2455 8899 1002 1121", "SBIN2341"),
            ],
          ),
        ),
      ),
    );
  }

  Column cardViewBankDetail(String accType, String accName, String accNumber, String ifsc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(Assets.imagesIcSbi, width: 40.0),
            horizontalSpace(10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("State Bank of India", style: textStyle14px500w),
                Text(accName, style: textStylePrimary14px500w),
              ],
            ),
          ],
        ),
        verticalSpace(4.0),
        Text("Name: Account information", style: textStyle12px500w),
        verticalSpace(2.0),
        Text("Account Name: Krc Homes Officials ", style: textStyle12px500w),
        verticalSpace(2.0),
        Text("Account Number: 2455 8899 1002 1121", style: textStyle12px500w),
        verticalSpace(2.0),
        Text("IFSC Code: SBIN2341", style: textStyle12px500w),
      ],
    );
  }
}
