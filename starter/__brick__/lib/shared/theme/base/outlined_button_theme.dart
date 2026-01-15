import 'package:flutter/material.dart';

import 'color_theme.dart';

class BaseOutlinedButtonTheme {
  BaseOutlinedButtonTheme._();

  static final OutlinedButtonThemeData lightTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: BaseColorTheme.lightTheme.primary,
      side: BorderSide(color: BaseColorTheme.lightTheme.primary),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
  );

  static final OutlinedButtonThemeData darkTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: BaseColorTheme.darkTheme.primary,
      side: BorderSide(color: BaseColorTheme.darkTheme.primary),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
  );
}
