import 'package:flutter/material.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/home/home_screen.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

import 'package:provider/provider.dart';

import 'provider/BaseProvider.dart';

// ignore: must_be_immutable
class Base extends StatelessWidget {
  Map<String, Widget> allDestinations;

  Base() {
    initState();
  }

  void initState() async {
    allDestinations = {
      Screens.kHomeScreen: HomeScreen(),

    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseProvider>(builder: (_, baseProvider, __) {
      return AnimatedContainer(
        transform: Matrix4Transform()
            .translate(x: baseProvider.xoffSet, y: baseProvider.yoffSet)
            .rotate(baseProvider.angle)
            .matrix4,
        duration: Duration(milliseconds: 250),
        child: WillPopScope(
            onWillPop: () {
              if (baseProvider.isOpen) baseProvider.close();
              if (baseProvider.currentScreen != Screens.kHomeScreen) baseProvider.currentScreen = Screens.kHomeScreen;
              return;
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(baseProvider.isOpen ? 12.0 : 0.0),
              child: Scaffold(
                // bottomNavigationBar: KitBottomNavigation(),
                body: SafeArea(
                  child: IndexedStack(
                    index: allDestinations.values.toList().indexOf(allDestinations[baseProvider.currentScreen]),
                    children: allDestinations.values.toList(),
                  ),
                ),
              ),
            )),
      );
    });
  }
}
