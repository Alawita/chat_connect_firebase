extension DateTimeExtension on DateTime {
  String toShortDateString() {
    return '${month}/${day}/${year}';
  }
}