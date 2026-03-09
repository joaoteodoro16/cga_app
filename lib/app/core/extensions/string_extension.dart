extension StringExtension on String {
  String? get nullIfEmpty {
    final text = trim();
    return text.isEmpty ? null : text;
  }
}