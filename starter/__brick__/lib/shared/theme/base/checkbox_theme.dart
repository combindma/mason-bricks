import 'package:flutter/material.dart';

import 'color_theme.dart';

class BaseCheckboxTheme {
  BaseCheckboxTheme._();

  static CheckboxThemeData lightTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(
      color: Colors.grey.shade700,
      width: 2,
    ),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return BaseColorTheme.lightTheme.primary;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return BaseColorTheme.lightTheme.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );

  static CheckboxThemeData darkTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: const BorderSide(
      color: Colors.white,
      width: 2,
    ),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.black;
      } else {
        return BaseColorTheme.darkTheme.primary;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return BaseColorTheme.darkTheme.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
