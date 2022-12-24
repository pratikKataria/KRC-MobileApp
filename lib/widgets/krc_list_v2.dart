import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Fonts.dart';

class KRCListViewV2 extends StatelessWidget {
  List<Widget>? children;
  EdgeInsets? margin;
  EdgeInsets? padding;

  KRCListViewV2({Key? key, List<Widget>? children, EdgeInsets? margin, EdgeInsets? padding}) : super(key: key) {
    this.children = children;
    this.margin = margin;
    this.padding = padding;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ListView.builder(
        itemCount: children!.length,
        itemBuilder: (context, i) {
          Color itemColor = i % 2 == 0 ? AppColors.cardColorDark : AppColors.cardColorLite;
          return Container(
            color: itemColor,
            padding: padding ?? EdgeInsets.all(20.0),
            margin: margin ?? EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
            child: children![i],
          );
        },
      ),
    );
  }
}
