import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';

class OutstandingPaymentsScreen extends StatelessWidget {
  const OutstandingPaymentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.0),
              Text("Account Status as on 5 Dec 2022", style: textStyle14px500w),
              verticalSpace(20.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.lineColor)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total Amount", style: textStyleSubText12px500w),
                          Text("50,000,000", style: textStyle14px600w),
                        ],
                      ),
                    ),
                  ),
                  horizontalSpace(20.0),
                  Expanded(
                    child: Container(
                      height: 70,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.lineColor)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(child: Text("Current Outstanding", style: textStyleSubText12px500w)),
                          Text("50,000,000", style: textStyle14px600w),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              verticalSpace(20.0),
              line(),
              verticalSpace(20.0),

              cardViewBankDetail("Principle Account", "Krc Homes Officials", "2455 8899 1002 1121", "SBIN2341"),
              cardViewBankDetail("GST Account", "Krc Homes Officials", "2455 8899 1002 1121", "SBIN2341"),
              cardViewBankDetail("Other Charges Account", "Krc Homes Officials", "2455 8899 1002 1121", "SBIN2341"),
            ],
          ),
        ),
      ),
    );
  }

  Container cardViewBankDetail(String accType, String accName, String accNumber, String ifsc) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(4.0),
          Text("Amount", style: textStyle14px500w),
          Text("25,000,000", style: textStyleRegular18pxW600),
          Row(
            children: [
              Text("Your invoice number is", style: textStyleSubText14px500w),
              Text(" ISBIN46345F", style: textStylePrimary14px500w),
            ],
          ),
          Text("On submission of RFR", style: textStyleSubText14px500w),
          verticalSpace(10.0),
          PmlButton(width: 97.0, height: 32.0, text: "Pay Now", textStyle: textStyleWhite12px500w),
          verticalSpace(24.0),
          line(),
         ],
      ),
    );
  }
}
