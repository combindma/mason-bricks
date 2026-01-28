import 'package:flutter/material.dart';

class BaseTextTheme {
  BaseTextTheme._();

  static final TextTheme baseTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(fontSize: 96.0, fontWeight: FontWeight.w600),
    displayMedium: const TextStyle().copyWith(fontSize: 60.0, fontWeight: FontWeight.w600, letterSpacing: 0),
    displaySmall: const TextStyle().copyWith(fontSize: 48.0, fontWeight: FontWeight.w600, letterSpacing: 0),

    headlineLarge: const TextStyle().copyWith(fontSize: 40.0, fontWeight: FontWeight.w600, letterSpacing: 0),
    headlineMedium: const TextStyle().copyWith(fontSize: 34.0, fontWeight: FontWeight.w600, letterSpacing: 0),
    headlineSmall: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 0),

    titleLarge: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.w500, letterSpacing: 0),
    titleMedium: const TextStyle().copyWith(fontSize: 20.0, fontWeight: FontWeight.w500, letterSpacing: 0),
    titleSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w500, letterSpacing: 0),

    bodyLarge: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w400, letterSpacing: 0),
    bodyMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0),

    labelLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: 0),
    labelMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0),
    labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500, letterSpacing: 0),
  );
}
