import 'package:flutter/material.dart';
import 'package:krc/res/Screens.dart';
import 'package:krc/ui/profile/model/profile_detail_response.dart';

/// Created by Pratik Kataria on 05-05-2021.

class BaseProvider extends ChangeNotifier {
  String _currentScreen;
  ProfileDetailResponse  profileDetailResponse;

  double xoffSet = 0;
  double yoffSet = 0;
  double sxoffSet = 0;
  double syoffSet = 0;
  double angle = 0;
  double sAngle = 0;

  bool isOpen = false;
  bool isPlaying = false;

  String get currentScreen => /*_currentScreen ?? */Screens.kHomeScreen;

  set currentScreen(String value) {
    _currentScreen = value;
    notifyListeners();
  }

  void open() {
    xoffSet = 150;
    yoffSet = 0;
    angle = -0.2;
    isOpen = true;

    sxoffSet = 122;
    syoffSet = 0;
    sAngle = -0.275;
    notifyListeners();
  }

  void close() {
    xoffSet = 0;
    yoffSet = 0;
    angle = 0;
    isOpen = false;

    sxoffSet = 0;
    syoffSet = 0;
    sAngle = 0;
    notifyListeners();
  }
}
