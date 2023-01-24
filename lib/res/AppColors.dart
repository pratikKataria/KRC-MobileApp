import 'package:flutter/material.dart';

/// Created by Pratik Kataria on 20-02-2021.

abstract class AppColors {
  //Basic colors
  static const colorPrimary = Color(0xFFC99A32);
  static const colorPrimaryDark = Color(0xFFECF0F3);
  static const colorPrimaryLight = Color(0xFFFFB6A6);
  static const colorPrimaryLightV2 = Color(0xFFFFF9F0);
  static const colorPrimaryLightV3 = Color(0xFFFFF2AF);

  static const colorSecondary = Color(0xFF163441);
  static const colorSecondaryDark = Color(0xFF173872);
  static const colorSecondaryV2 = Color(0xFF1A3D7C);
  static const colorSecondaryLight = Color(0xFFD3D9E9);

  static const textColor = Color(0xFF163441);
  static const textColorBlue = Color(0xFF00B8FF);
  static const textColorBlack = Color(0xFF30303C);
  static const textColorHeather = Color(0xFFACBEC9);
  static const textColorSubText = Color(0xFF878787);
  static const textColorGreen = Color(0xFF26E35B);
  static const textColorGrey = Color(0xFFE6EAF5);

  static const inputFieldBackgroundColor = Color(0xFF5F5F5F);
  static const inputFieldBackgroundColor2 = Color(0xFFF6F6F6);

  static const white = Color(0xFFFFFFFF);
  static const blue = Color(0xFF0093FF);
  static const black = Color(0xFF000000);
  static const background = Color(0xFFECF0F3);
  static const red = Colors.red;

  //Shimmer color
  static const baseLightColor = Color(0xFFF5F5F5);
  static const highLightColor = Color(0xFFE6E6E6);
  static const shimmerBackgroundColor = Color(0xFFEAEAEA);


  //App Specific color
  static const screenBackgroundColor = Color(0xFFFFFFFF);
  static const lineColor = Color(0xFFD5DADC);
  static const cardColorLite = Color(0xFF373737);
  static const cardColorDark = Color(0xFF2A2A2A);
  static const cardColorDark2 = Color(0xFF303030);
  static const lightGrey = Color(0xFF333333);
  static const applicantsCardBackground = Color(0xFFF7F7F7);

  static const blueColor = Color(0xFF161D2C);

  static const transparent = Colors.transparent;
  static const bookingDetailCardBg = Color(0xFFF6F5F5);
  static const profileDetailApplicantBg = Color(0xFFFF7F7F7);
  static const chipBg = Color(0xFFEBEBEB);
  static const attachmentBg = Color(0xFFF6F6F6);

   static  MaterialColor primaryColorShades = MaterialColor(
    0xFFC99A32,
    <int, Color>{
      50: Color(0xFF0FFC99A32),
      100: Color(0xFFA4A4BF),
      200: Color(0xFFA4A4BF),
      300: Color(0xFF9191B3),
      400: Color(0xFF7F7FA6),
      500: Color(0xFF181861),
      600: Color(0xFF6D6D99),
      700: Color(0xFF5B5B8D),
      800: Color(0xFF494980),
      900: Color(0xFF181861),
    },
  );
}
