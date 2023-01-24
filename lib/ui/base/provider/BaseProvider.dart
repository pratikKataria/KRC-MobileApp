import 'package:flutter/material.dart';
import 'package:krc/res/Screens.dart';

/// Created by Pratik Kataria on 05-05-2021.

class BaseProvider extends ChangeNotifier {
  late bool isLogin;

  BaseProvider(bool isLogin) {
    this.isLogin = isLogin;
    showAppbarAndBottomNavigation = isLogin;
  }

  bool filterIsOpen = false;
  bool _drawerIsOpen = false;
  bool showAppbarAndBottomNavigation = false;
  String currentScreen = Screens.kHomeScreen;

  late GlobalKey<ScaffoldState> drawerKey;

  // StackSetDSA<String> screenStack = StackSetDSA<String>();

  //getter
  get drawerStatus => _drawerIsOpen;

  //Notifiers
  void toggleFilter() {
    filterIsOpen = !filterIsOpen;
    notifyListeners();
  }

  void openDrawer() {
    _drawerIsOpen = true;
    drawerKey.currentState?.openDrawer();
    notifyListeners();
  }

  void closeDrawer() {
    _drawerIsOpen = false;
    drawerKey.currentState?.openEndDrawer();
    notifyListeners();
  }

  void setBottomNavScreen(String incomingScreen) {
    currentScreen = incomingScreen;
    notifyListeners();
  }

  void hideToolTip() {
    showAppbarAndBottomNavigation = false;
    notifyListeners();
  }

  void showToolTip() {
    showAppbarAndBottomNavigation = true;
    notifyListeners();
  }
}
