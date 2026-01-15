import 'package:flutter/material.dart';

class BaseTextTheme {
  BaseTextTheme._();

  static final TextTheme lightTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(fontSize: 96.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    displayMedium: const TextStyle().copyWith(fontSize: 60.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    displaySmall: const TextStyle().copyWith(fontSize: 48.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),

    headlineLarge: const TextStyle().copyWith(fontSize: 40.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    headlineMedium: const TextStyle().copyWith(fontSize: 34.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    headlineSmall: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),

    titleLarge: const TextStyle().copyWith(fontSize: 20.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    titleSmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),

    bodyLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: -0.2),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: -0.2),
    bodySmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: -0.2),

    labelLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black, letterSpacing: -0.2),
    labelMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black, letterSpacing: -0.2),
    labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.black, letterSpacing: -0.2),
  );

  static final TextTheme darkTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(fontSize: 96.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    displayMedium: const TextStyle().copyWith(fontSize: 60.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    displaySmall: const TextStyle().copyWith(fontSize: 48.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    
    headlineLarge: const TextStyle().copyWith(fontSize: 40.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    headlineMedium: const TextStyle().copyWith(fontSize: 34.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    headlineSmall: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),

    titleLarge: const TextStyle().copyWith(fontSize: 20.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),
    titleSmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, letterSpacing: -0.2),

    bodyLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: -0.2),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: -0.2),
    bodySmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: -0.2),

    labelLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, letterSpacing: -0.2),
    labelMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: -0.2),
    labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500, letterSpacing: -0.2),
  );
}
