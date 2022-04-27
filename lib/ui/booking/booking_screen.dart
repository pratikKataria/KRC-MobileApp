import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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
            Header("Booking"),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nova at raheja viva", style: textStyleWhite14px600w),
          Text("1203 Units", style: textStyleWhite14px600w),
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                color: AppColors.cardColorDark2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nova at raheja viva", style: textStyleWhite20px600w),
                    verticalSpace(10.0),
                    Text(
                      "Raheja Viva is the most sought after development in West Pune for Plots and Villas. Looking to buy villas in Pune/ plots in Pune? ",
                      style: textStyleSubText14px500w ,
                    ),
                    verticalSpace(10.0),
                    RichText(
                      text: TextSpan(
                        text: "Unit: ",
                        style: textStyleSubText12px600w,
                        children: [TextSpan(text: "C3299", style: textStyleWhite12px700w)],
                      ),
                    ),
                    verticalSpace(10.0),
                    RichText(
                      text: TextSpan(
                        text: "Tower: ",
                        style: textStyleSubText12px600w,
                        children: [TextSpan(text: "A", style: textStyleWhite12px700w)],
                      ),
                    ),
                    verticalSpace(10.0),
                    RichText(
                      text: TextSpan(
                        text: "location: ",
                        style: textStyleSubText12px600w,
                        children: [TextSpan(text: "507 West Street Pune", style: textStyleWhite12px700w)],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
