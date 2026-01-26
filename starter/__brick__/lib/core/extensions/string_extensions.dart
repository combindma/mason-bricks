extension StringExtensions on String {
  // Validation
  bool get isEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  bool get isPhone => RegExp(r'^\+?[\d\s-]{9,}$').hasMatch(this);
  bool get isUrl => Uri.tryParse(this)?.hasAbsolutePath ?? false;
  bool get isNumeric => double.tryParse(this) != null;

  // Formatting
  String get capitalized => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  String get titleCase => split(' ').map((word) => word.capitalized).join(' ');
  String get initials => split(' ').map((word) => word.isNotEmpty ? word[0] : '').take(2).join().toUpperCase();

  // Truncation
  String truncate(int maxLength, {String suffix = '...'}) {
    return length <= maxLength ? this : '${substring(0, maxLength)}$suffix';
  }

  // Nullability helpers
  String? get nullIfEmpty => isEmpty ? null : this;

  // Parsing
  int? toIntOrNull() => int.tryParse(this);
  double? toDoubleOrNull() => double.tryParse(this);

  // Slug
  String get slug => toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-|-$'), '');
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
  String orEmpty() => this ?? '';
}