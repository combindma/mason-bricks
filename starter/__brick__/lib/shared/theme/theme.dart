import 'package:flutter/material.dart';

import 'base/appbar_theme.dart';
import 'base/bottom_sheet_theme.dart';
import 'base/checkbox_theme.dart';
import 'base/chip_theme.dart';
import 'base/color_theme.dart';
import 'base/elevated_button_theme.dart';
import 'base/outlined_button_theme.dart';
import 'base/text_field_theme.dart';
import 'base/text_theme.dart';

class BaseTheme {
  BaseTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    //fontFamily: 'Felicita',
    brightness: Brightness.light,
    colorScheme: BaseColorTheme.lightTheme,
    appBarTheme: BaseAppBarTheme.lightTheme,
    textTheme: BaseTextTheme.lightTheme,
    checkboxTheme: BaseCheckboxTheme.lightTheme,
    chipTheme: BaseChipTheme.lightTheme,
    bottomSheetTheme: BaseBottomSheetTheme.lightTheme,
    elevatedButtonTheme: BaseElevatedButtonTheme.lightTheme,
    outlinedButtonTheme: BaseOutlinedButtonTheme.lightTheme,
    inputDecorationTheme: BaseTextFieldTheme.lightTheme,
    dividerColor: Colors.grey.shade400,
    tabBarTheme: TabBarThemeData(
      labelColor: BaseColorTheme.lightTheme.primary,
      dividerColor: Colors.grey,
      unselectedLabelColor: Colors.grey,
      tabAlignment: TabAlignment.start,
      indicatorColor: BaseColorTheme.lightTheme.primary,
    ),
  );
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    //fontFamily: 'Felicita',
    brightness: Brightness.dark,
    colorScheme: BaseColorTheme.darkTheme,
    appBarTheme: BaseAppBarTheme.darkTheme,
    textTheme: BaseTextTheme.darkTheme,
    checkboxTheme: BaseCheckboxTheme.darkTheme,
    chipTheme: BaseChipTheme.darkTheme,
    bottomSheetTheme: BaseBottomSheetTheme.darkTheme,
    elevatedButtonTheme: BaseElevatedButtonTheme.darkTheme,
    outlinedButtonTheme: BaseOutlinedButtonTheme.darkTheme,
    inputDecorationTheme: BaseTextFieldTheme.darkTheme,
    dividerColor: Colors.grey.shade700,
    tabBarTheme: TabBarThemeData(
      labelColor: BaseColorTheme.darkTheme.primary,
      dividerColor: Colors.grey,
      unselectedLabelColor: Colors.grey,
      tabAlignment: TabAlignment.start,
      indicatorColor: BaseColorTheme.darkTheme.primary,
    ),
  );
}
