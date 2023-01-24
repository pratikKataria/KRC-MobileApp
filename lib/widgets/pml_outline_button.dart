import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';

class PmlOutlineButton extends StatelessWidget {
  final Function? onTap;
  final String? text;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? textStyle;
  final Colors? color;
  final Colors? fillColor;
  final double? height;
  final double? width;

  const PmlOutlineButton({
    this.onTap,
    this.text,
    this.width,
    this.padding,
    this.margin,
    this.textStyle,
    this.color,
    this.fillColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        width: width,
        height: height ?? 54.0,
        padding: padding,
        decoration: BoxDecoration(
          color: fillColor as Color? ?? Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColors.colorSecondary, width: 1.5),
        ),
        child: Center(
          child: Text(
            '$text',
            style: textStyle ?? textStyle14px500w,
          ),
        ),
      ),
    );
  }
}
