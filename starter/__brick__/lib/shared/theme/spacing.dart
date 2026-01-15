import 'package:flutter/painting.dart';

class BaseSpacing{
  BaseSpacing._();

  static const double appBarHeight = 56.0;
  static const double defaultSpace = 24.0;
  static const double containerPadding = 16.0;

  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(BaseSpacing.defaultSpace);

  //Used when there is no appBar
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: BaseSpacing.appBarHeight,
    left: BaseSpacing.defaultSpace,
    bottom: BaseSpacing.defaultSpace,
    right: BaseSpacing.defaultSpace
  );
}