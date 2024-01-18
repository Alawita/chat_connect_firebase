import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin CustomDateTimeFormatter {
  String formatChatDateTime(DateTime dateTime, BuildContext context) {
    // Format the DateTime to a more concise representation for chat messages
    final timeFormat = TimeOfDay.fromDateTime(dateTime).format(context);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (dateTime.isAfter(today)) {
      return 'Today, $timeFormat';
    } else if (dateTime.isAfter(yesterday)) {
      return 'Yesterday, $timeFormat';
    } else {
      final dateFormat = DateFormat('d/MMM/y');

      final formattedDate = dateFormat.format(dateTime);
      return '$formattedDate, $timeFormat';
    }
  }
}
