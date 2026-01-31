import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showAppToast({
  required String message,
  ToastGravity gravity = .TOP,
  bool isError = false,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: isError ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: gravity,
    backgroundColor: isError ? Colors.red.shade500 : Colors.black,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}