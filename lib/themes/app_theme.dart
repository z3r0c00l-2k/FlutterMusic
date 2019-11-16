import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        primaryColor: Colors.white, primaryColorDark: Colors.white);
  }
}
