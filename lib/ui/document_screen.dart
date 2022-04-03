import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key key}) : super(key: key);

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
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
            Header("Document"),
            verticalSpace(20.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: KRCListView(
                  children: list.map<Widget>((e) => cardViewBooking()).toList(),
                ),
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
          Text("Nova at raheja viva", style: textStyleWhite16px600w),
          Text("1203 Units", style: textStyleWhite16px600w),
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
                    Text("Nova at raheja viva", style: textStyleWhiteHeavy24px),
                    Text("1230 Units", style: textStyleWhite20px700w),
                    verticalSpace(10.0),
                    Container(
                      height: 150.0,
                      child: KRCListView(
                        margin: EdgeInsets.all(0),
                        padding: EdgeInsets.all(8.0),
                        children: [
                          ...["Agreement for sale", "LOI", "Price List"].map(
                            (e) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("$e", style: textStyleWhite16px500w),
                                Icon(Icons.arrow_circle_down_outlined, color: AppColors.white, size: 18.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
