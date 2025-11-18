import 'package:cgc_project/theme/color_contanst.dart';
import 'package:flutter/material.dart';

///Custom text styles that are used across the application.
class CustomTextStyles {
  CustomTextStyles();

  static buildTextTheme(TextTheme base, Size size) {
    return base.copyWith(
      titleMedium: TextStyle(
        fontSize: 12,
        color: Color.fromRGBO(130, 130, 130, 1),
      ),
      bodySmall: TextStyle(
        fontSize: 10,
        letterSpacing: 0,
        color: Color.fromRGBO(130, 130, 130, 1),
      ),
      bodyMedium: TextStyle(fontSize: 16, color: kWhite),
      labelMedium: TextStyle(
        fontSize: 14,
        letterSpacing: 0,
        color: Color.fromRGBO(130, 130, 130, 1),
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        color: Color.fromRGBO(130, 130, 130, 1),
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(130, 130, 130, 1),
      ),
      labelLarge: TextStyle(
        fontSize: 24,
        color: Color.fromRGBO(130, 130, 130, 1),
      ),
      headlineMedium: TextStyle(
        fontSize: 30,
        color: Color.fromRGBO(130, 130, 130, 1),
      ),
      headlineLarge: TextStyle(
        fontSize: 36,
        color: Color.fromRGBO(130, 130, 130, 1),
      ),
    );
  }
}
