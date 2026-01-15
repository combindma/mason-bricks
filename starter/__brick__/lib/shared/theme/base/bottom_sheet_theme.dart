import 'package:flutter/material.dart';

class BaseBottomSheetTheme {
  BaseBottomSheetTheme._();

  static BottomSheetThemeData lightTheme = const BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints: BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
    ),
  );

  static BottomSheetThemeData darkTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.grey.shade900,
    modalBackgroundColor: Colors.grey.shade900,
    constraints: BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
    ),
  );
}
