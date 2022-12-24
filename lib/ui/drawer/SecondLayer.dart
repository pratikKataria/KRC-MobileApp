import 'package:flutter/material.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';
import 'package:provider/provider.dart';

SecondLayerState? secondLayerState;

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
      return Column(
        children: [
          Row(
            children: [],
          )
        ],
      );
    });
  }
}
