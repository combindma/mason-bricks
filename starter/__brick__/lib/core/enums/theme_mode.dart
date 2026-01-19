import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark,
  system;

  static AppThemeMode fromString(String? value) {
    return AppThemeMode.values.firstWhere(
            (e) => e.name == value,
        orElse: () => AppThemeMode.system
    );
  }

  ThemeMode get flutterThemeMode {
    switch (this) {
      case AppThemeMode.light: return ThemeMode.light;
      case AppThemeMode.dark: return ThemeMode.dark;
      case AppThemeMode.system: return ThemeMode.system;
    }
  }
}