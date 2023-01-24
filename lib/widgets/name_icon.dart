import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:krc/res/Fonts.dart';

class NameIcon extends StatelessWidget {
  final String firstName;
  final Color? backgroundColor;
  final Color? textColor;

  final List<Color> listOfColors = [
    Color(0xFF8EA7E9),
    Color(0xFF85586F),
    Color(0xFF54BAB9),
    Color(0xFFAC7088),
    Color(0xFF7D9D9C),
    Color(0xFF5F7161),
    Color(0xFFBB6464)
  ];

  NameIcon({
    Key? key,
    required this.firstName,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);

  String get firstLetter => this.firstName.substring(0, 1).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: listOfColors[new Random().nextInt(5)],
          ),
          padding: EdgeInsets.all(8.0),
          child: Text(this.firstLetter, style: textStyleWhite16px700w),
        ),
      ),
    );
  }
}
