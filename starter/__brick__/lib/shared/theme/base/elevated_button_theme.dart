import 'package:flutter/material.dart';

import 'color_theme.dart';

class BaseElevatedButtonTheme {
  BaseElevatedButtonTheme._();

  static final ElevatedButtonThemeData lightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: BaseColorTheme.lightTheme.primary,
      foregroundColor: BaseColorTheme.lightTheme.onPrimary,
      disabledForegroundColor: Colors.grey.shade600,
      disabledBackgroundColor: Colors.grey.shade300,
      side: const BorderSide(color: Colors.transparent),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
  );

  static final ElevatedButtonThemeData darkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: BaseColorTheme.darkTheme.primary,
      foregroundColor: BaseColorTheme.darkTheme.onPrimary,
      disabledForegroundColor: Colors.grey.shade600,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.transparent),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
  );
}
