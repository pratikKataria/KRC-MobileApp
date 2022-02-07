import 'package:flutter/material.dart';
import 'package:krc/res/AppColors.dart';
import 'package:krc/res/Images.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:provider/provider.dart';

SecondLayerState secondLayerState;

class SecondLayer extends StatefulWidget {
  @override
  SecondLayerState createState() => SecondLayerState();

// openTab() => createState().openTab();
}

class SecondLayerState extends State<SecondLayer> {
  @override
  Widget build(BuildContext context) {
    secondLayerState = this;
    return Consumer<BaseProvider>(builder: (_, baseProvider, __) {
      return AnimatedContainer(
          transform: Matrix4Transform()
              .translate(x: baseProvider.sxoffSet, y: baseProvider.syoffSet)
              .rotate(baseProvider.sAngle)
              .matrix4,
          duration: Duration(milliseconds: 550),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.inputFieldBackgroundColor),
          child: Column(
            children: [

              Row(
                children: [],
              )
            ],
          ));
    });
  }
}
