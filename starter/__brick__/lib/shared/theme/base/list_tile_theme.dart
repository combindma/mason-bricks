import 'package:flutter/material.dart';

class BaseListTileTheme {
  BaseListTileTheme._();

  static final ListTileThemeData theme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
    dense: true,
  );
}
