import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';

class PmlButton extends StatelessWidget {
  final Function? onTap;
  final String? text;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? textStyle;
  final Color? color;
  final Color? borderColor;
  final double? height;
  final double? width;
  final double? radius;
  final Widget? child;

  const PmlButton({
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
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        width: width,
        height: height ?? 40.0,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: color ?? AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(radius ?? 0.0),
          border: Border.all(color: borderColor?? AppColors.transparent)
        ),
        child: child ??
            Center(
              child: Text(
                '$text',
                style: textStyle ?? textStyleWhite14px700w,
              ),
            ),
      ),
    );
  }
}
