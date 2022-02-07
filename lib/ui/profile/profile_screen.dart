import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header('Profile'),
            verticalSpace(20.0),
            Column(
              children: [
                Row(
                  children: [
                    horizontalSpace(20.0),
                    Image.asset(Images.kIconProfile, height: 90.0),
                    horizontalSpace(20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(6.0),
                        Text('stetigSting@gmail.com', style: textStyleWhite16px500w),
                        verticalSpace(6.0),
                        Text('Mr Stetig Singh', style: textStyleWhite16px500w),
                        verticalSpace(6.0),
                        Text('25-05-1999 \u2022 1234567890', style: textStyleWhite16px500w),
                        verticalSpace(20.0),
                      ],
                    ),
                  ],
                ),
                verticalSpace(50.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horizontalSpace(50.0),
                    Image.asset(
                      Images.kIconMapExt,
                      height: 50.0,
                    ),
                    horizontalSpace(16.0),
                    RichText(
                      maxLines: 10,
                      text: TextSpan(
                        text: 'Permanent Address\n',
                        style: textStyleWhite16px600w,
                        children: [
                          TextSpan(
                            text: 'Promount 12/23 block 233V East\nMumbai sector 52',
                            style: textStyleSubText14px500w,
                          ),
                        ],
                      ),
                    ),
                    horizontalSpace(20.0),
                  ],
                ),
                verticalSpace(20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    horizontalSpace(50.0),
                    Image.asset(
                      Images.kIconMapExt,
                      height: 50.0,
                    ),
                    horizontalSpace(16.0),
                    RichText(
                      maxLines: 10,
                      text: TextSpan(
                        text: 'Mailing Address\n',
                        style: textStyleWhite16px600w,
                        children: [
                          TextSpan(
                            text: 'Promount 12/23 block 233V East\n Mumbai sector 52',
                            style: textStyleSubText14px500w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
