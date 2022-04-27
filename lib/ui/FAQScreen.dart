import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';
import 'package:krc/widgets/krc_list.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header("FAQs"),
            verticalSpace(20.0),
            Expanded(
              child: KRCListView(
                padding: EdgeInsets.only(top: 16.0, left: 10.0, right: 10.0),
                margin: EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
                children: [
                  // Header(image: Images.kIconFaq, text: 'FAQs'),
                  ExpandablePanel(
                    theme: ExpandableThemeData(iconColor: AppColors.white),
                    header: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.help, color: AppColors.white),
                          horizontalSpace(20.0),
                          Text(
                            'What is TDS on property?',
                            style: textStyleWhite14px600w,
                          ),
                        ],
                      ),
                    ),
                    expanded: Text(
                      'Lorem ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreet dolore magna aliqua. Ut enim adminim veniam, quis nostrudexercitation ullamco laboris nisi utaliquip ex ea commodo consequat',
                      softWrap: true,
                      style: textStyleWhite14px500w,
                    ),
                    collapsed: null,
                  ),
                  ExpandablePanel(
                    theme: ExpandableThemeData(iconColor: AppColors.white),
                    header: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.help, color: AppColors.white),
                          horizontalSpace(20.0),
                          Expanded(
                            child: Text(
                              'What if I don\'t have the PAN of seller, is it mandatory?',
                              style: textStyleWhite14px600w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    expanded: Text(
                      'Lorem ipsum dolor sit amet,consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreet dolore magna aliqua. Ut enim adminim veniam, quis nostrudexercitation ullamco laboris nisi utaliquip ex ea commodo consequat',
                      softWrap: true,
                      style: textStyleWhite14px500w,
                    ),
                    collapsed: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
