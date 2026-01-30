import 'package:flutter/material.dart';

class BaseTextTheme {
  BaseTextTheme._();

  static final TextTheme baseTheme = TextTheme(
    // Display — hero text, splash screens (rarely used on mobile)
    displayLarge: const TextStyle().copyWith(fontSize: 57.0, fontWeight: FontWeight.w700, letterSpacing: -0.25),
    displayMedium: const TextStyle().copyWith(fontSize: 45.0, fontWeight: FontWeight.w700, letterSpacing: 0.0),
    displaySmall: const TextStyle().copyWith(fontSize: 36.0, fontWeight: FontWeight.w700, letterSpacing: 0.0),

    // Headline — section headers, modal titles
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.w600, letterSpacing: 0.0),
    headlineMedium: const TextStyle().copyWith(fontSize: 28.0, fontWeight: FontWeight.w600, letterSpacing: 0.0),
    headlineSmall: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 0.0),

    // Title — card titles, list headers, app bar
    titleLarge: const TextStyle().copyWith(fontSize: 22.0, fontWeight: FontWeight.w600, letterSpacing: 0.0),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w600, letterSpacing: 0.15),
    titleSmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, letterSpacing: 0.1),

    // Body — primary content, paragraphs
    bodyLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 1.5),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.43),
    bodySmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.33),

    // Label — buttons, chips, form labels, captions
    labelLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
    labelSmall: const TextStyle().copyWith(fontSize: 11.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
  );
}