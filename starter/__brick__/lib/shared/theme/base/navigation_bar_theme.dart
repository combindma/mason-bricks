import 'package:flutter/material.dart';

class BaseNavigationBarTheme {
  BaseNavigationBarTheme._();

  static NavigationBarThemeData lightTheme = NavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.white,
    indicatorColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    height: 62,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(
          size: 24,
          color: Colors.black,
        );
      }
      return IconThemeData(
        size: 24,
        color: Colors.grey.shade500,
      );
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        );
      }
      return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade600,
      );
    }),
  );

  static NavigationBarThemeData darkTheme = NavigationBarThemeData(
    elevation: 0,
    backgroundColor: Colors.grey.shade900,
    indicatorColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    height: 62,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(
          size: 24,
          color: Colors.white,
        );
      }
      return IconThemeData(
        size: 24,
        color: Colors.grey.shade600,
      );
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        );
      }
      return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade600,
      );
    }),
  );
}