import 'package:flutter/material.dart';

class BaseColorTheme {
  BaseColorTheme._();

  static final ColorScheme lightTheme = ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.black,
    error: Colors.redAccent.shade700,
    surface: Colors.white,
    onSurface: Colors.black,
  );

  static final ColorScheme darkTheme = ColorScheme.dark(
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.white,
    error: Colors.redAccent.shade700,
    surface: Colors.black,
    onSurface: Colors.white,
  );
}
