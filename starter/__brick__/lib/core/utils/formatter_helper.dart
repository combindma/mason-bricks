import 'package:intl/intl.dart';

class FormatterHelper {
  FormatterHelper._();

  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double? amount) {
    return NumberFormat.currency(locale: 'fr', symbol: 'DH', decimalDigits: 0).format(amount);
  }
}
