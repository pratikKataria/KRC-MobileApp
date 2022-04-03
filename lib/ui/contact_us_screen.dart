import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header("Contact"),
            verticalSpace(20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Relation Manager", style: textStyleWhite20px600w),
                  verticalSpace(16.0),
                  Text("Ramesh Sharma", style: textStyleWhite14px500w),
                  Text("r.sharma@gmail.com", style: textStyleWhite14px500w),
                  Text("12345-98765", style: textStyleWhite14px500w),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Images.kIconCall),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Images.kIconGmail),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(Images.kIconWhats),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
