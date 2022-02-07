import 'package:flutter/material.dart';
import 'package:krc/ui/base/Base.dart';
import 'package:krc/ui/base/provider/BaseProvider.dart';

import 'package:provider/provider.dart';

import 'FirstLayer.dart';
import 'SecondLayer.dart';
import 'ThirdLayer.dart';

class KitDrawer extends StatefulWidget {
  @override
  _KitDrawerState createState() => _KitDrawerState();
}

class _KitDrawerState extends State<KitDrawer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseProvider>(
        create: (_) => BaseProvider(),
        child: Scaffold(
          body: Stack(
            children: [
              FirstLayer(),
              SecondLayer(),
              ThirdLayer(),
              Base(),
            ],
          ),
        ));
  }
}
