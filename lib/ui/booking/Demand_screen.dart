import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';
import 'package:krc/widgets/pml_button.dart';

class DemandScreen extends StatefulWidget {
  const DemandScreen({Key key}) : super(key: key);

  @override
  _DemandScreenState createState() => _DemandScreenState();
}

class _DemandScreenState extends State<DemandScreen> {
  AnimationController menuAnimController;
  List list = ["", "", ""];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("Demand  "),
            verticalSpace(20.0),
            Expanded(
              child: KRCListView(
                children: list.map<Widget>((e) => cardViewBooking()).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  cardViewBooking() {
    return InkWell(
      onTap: () {
        _modalBottomSheetMenu();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("#INVI1201", style: textStyleWhite14px600w),
              Text("RS 43,00,00", style: textStyleWhite14px600w),
            ],
          ),
          Spacer(),
          PmlButton(
            height: 30.0,
            text: "PAY NOW",
            textStyle: textStyleWhite12px600w,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
          ),
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
          return Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
                color: AppColors.cardColorDark2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("RS 74,89,00", style: textStyleWhiteHeavy24px),
                    verticalSpace(10.0),
                    RichText(
                      text: TextSpan(
                        text: "No:",
                        style: textStyleSubText12px600w,
                        children: [
                          TextSpan(text: " INVI1201", style: textStyleWhite12px700w),
                        ],
                      ),
                    ),
                    verticalSpace(10.0),
                    RichText(
                      text: TextSpan(
                        text: "Slab:",
                        style: textStyleSubText12px600w,
                        children: [
                          TextSpan(text: " On submission of RFR", style: textStyleWhite12px700w),
                        ],
                      ),
                    ),
                    verticalSpace(40.0),
                    PmlButton(text: "Download"),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
