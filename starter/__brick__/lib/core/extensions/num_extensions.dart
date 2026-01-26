import 'package:intl/intl.dart';

extension NumExtensions on num {
  // Currency
  String toCurrency({String symbol = 'MAD', int decimals = 2}) {
    return '${NumberFormat.currency(locale: 'fr', symbol: '', decimalDigits: decimals).format(this)} $symbol';
  }

  String toCompact() => NumberFormat.compact().format(this);

  // Duration
  Duration get milliseconds => Duration(milliseconds: toInt());
  Duration get seconds => Duration(seconds: toInt());
  Duration get minutes => Duration(minutes: toInt());
  Duration get hours => Duration(hours: toInt());
  Duration get days => Duration(days: toInt());

  // Percentage
  String toPercent({int decimals = 0}) => '${toStringAsFixed(decimals)}%';

  // Clamp shorthand
  num clampMin(num min) => this < min ? min : this;
  num clampMax(num max) => this > max ? max : this;
}