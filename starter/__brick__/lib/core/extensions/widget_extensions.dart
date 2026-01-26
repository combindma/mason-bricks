import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  // Padding
  Widget padAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);
  Widget padHorizontal(double value) => Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);
  Widget padVertical(double value) => Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);
  Widget padBottom(double value) => Padding(padding: EdgeInsets.only(bottom: value), child: this);
  Widget padOnly({double left = 0, double top = 0, double right = 0, double bottom = 0}) =>
      Padding(padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom), child: this);

  // Gestures
  Widget onTap(VoidCallback onTap) => GestureDetector(onTap: onTap, child: this);

  // Decoration
  Widget rounded(double radius) => ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
}