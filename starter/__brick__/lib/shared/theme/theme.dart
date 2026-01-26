import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'base/appbar_theme.dart';
import 'base/bottom_sheet_theme.dart';
import 'base/checkbox_theme.dart';
import 'base/chip_theme.dart';
import 'base/color_theme.dart';
import 'base/elevated_button_theme.dart';
import 'base/list_tile_theme.dart';
import 'base/navigation_bar_theme.dart';
import 'base/outlined_button_theme.dart';
import 'base/text_field_theme.dart';
import 'base/text_theme.dart';

class BaseTheme {
  BaseTheme._();

  static ThemeData materialLight = ThemeData(
    splashColor: Colors.transparent,
    brightness: Brightness.light,
    colorScheme: BaseColorTheme.lightTheme,
    appBarTheme: BaseAppBarTheme.lightTheme,
    navigationBarTheme: BaseNavigationBarTheme.lightTheme,
    textTheme: GoogleFonts.tikTokSansTextTheme(BaseTextTheme.lightTheme),
    checkboxTheme: BaseCheckboxTheme.lightTheme,
    chipTheme: BaseChipTheme.lightTheme,
    bottomSheetTheme: BaseBottomSheetTheme.lightTheme,
    elevatedButtonTheme: BaseElevatedButtonTheme.lightTheme,
    outlinedButtonTheme: BaseOutlinedButtonTheme.lightTheme,
    inputDecorationTheme: BaseTextFieldTheme.lightTheme,
    dividerColor: Colors.grey.shade300,
    tabBarTheme: TabBarThemeData(
      labelColor: BaseColorTheme.lightTheme.primary,
      dividerColor: Colors.grey,
      unselectedLabelColor: Colors.grey,
      tabAlignment: TabAlignment.start,
      indicatorColor: BaseColorTheme.lightTheme.primary,
    ),
    listTileTheme: BaseListTileTheme.theme,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );


  static ThemeData materialDark = ThemeData(
    splashColor: Colors.transparent,
    brightness: Brightness.dark,
    colorScheme: BaseColorTheme.darkTheme,
    appBarTheme: BaseAppBarTheme.darkTheme,
    navigationBarTheme: BaseNavigationBarTheme.darkTheme,
    textTheme: GoogleFonts.tikTokSansTextTheme(BaseTextTheme.darkTheme),
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
    listTileTheme: BaseListTileTheme.theme,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
