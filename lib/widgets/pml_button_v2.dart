import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';

class PmlButtonV2 extends StatelessWidget {
  final Function onTap;
  final String text;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextStyle textStyle;
  final Color color;
  final double height;
  final double width;
  final double radius;
  final Widget child;

  const PmlButtonV2({
    this.onTap,
    this.text,
    this.padding,
    this.margin,
    this.textStyle,
    this.color,
    this.child,
    this.height,
    this.width,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 40.0,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? AppColors.colorPrimary,
        // borderRadius: BorderRadius.circular(radius ?? 80.0),
      ),
      child: child ??
          Center(
            child: Text(
              '$text',
              style: textStyle ?? textStyleWhite18px600w,
            ),
          ),
    );
  }
}
