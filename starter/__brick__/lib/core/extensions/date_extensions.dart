import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  // Formatting
  String format([String pattern = 'dd/MM/yyyy']) => DateFormat(pattern).format(this);
  String get timeAgo => _timeAgo();
  String get monthYear => DateFormat('MMMM yyyy').format(this);
  String get dayMonth => DateFormat('d MMM').format(this);
  String get fullDate => DateFormat('EEEE, d MMMM yyyy').format(this);
  String get time => DateFormat('HH:mm').format(this);

  // Comparison
  bool get isToday => _isSameDay(DateTime.now());
  bool get isYesterday => _isSameDay(DateTime.now().subtract(const Duration(days: 1)));
  bool get isTomorrow => _isSameDay(DateTime.now().add(const Duration(days: 1)));
  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());
  bool get isThisYear => year == DateTime.now().year;

  bool _isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;

  bool isSameDay(DateTime other) => _isSameDay(other);

  // Manipulation
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
  DateTime get startOfMonth => DateTime(year, month);
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59);

  DateTime addDays(int days) => add(Duration(days: days));
  DateTime subtractDays(int days) => subtract(Duration(days: days));

  // Age calculation
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  // Time ago helper
  String _timeAgo() {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()} ans';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()} mois';
    if (diff.inDays > 0) return '${diff.inDays} j';
    if (diff.inHours > 0) return '${diff.inHours} h';
    if (diff.inMinutes > 0) return '${diff.inMinutes} min';
    return 'maintenant';
  }
}