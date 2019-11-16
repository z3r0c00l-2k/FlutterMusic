import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildLightTheme() {
    final ThemeData base = ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        primaryColorDark: Colors.white);
    return base;
  }
}
