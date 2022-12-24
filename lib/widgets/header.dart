import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/utils/Utility.dart';
import 'package:krc/widgets/pml_button.dart';

class Header extends StatelessWidget {
  final String heading;

  const Header(this.heading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      color: AppColors.inputFieldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          PmlButton(
            height: 34.0,
            width: 34.0,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(Images.kIconBack),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Spacer(),
          Text("$heading", style: textStyleWhite16px600w),
          horizontalSpace(30.0),
          Spacer(),
        ],
      ),
    );
  }
}
