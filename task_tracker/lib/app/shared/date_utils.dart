import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:intl/intl.dart';

class DateUtil {}

/// Generates a hash with day month and year to be used in keys for maps
/// @author: luiz walber
String dateDayHash(DateTime day) {
  return day != null ? DateFormat('yyyy-MM-dd').format(day) : null;
}

/// Generates a hash with day month and year to be used in keys for maps
/// @author: luiz walber
String dateMonthHash(DateTime day) {
  return day != null ? DateFormat('yyyy-MM').format(day) : null;
}

/// Check if two dates is in the same day
bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

String presentDataDayMonthAsTextYear(BuildContext context, DateTime date) {
  Locale locale = I18n.of(context).locale;
  String languageCode =
      locale != null ? '${locale.languageCode}_${locale.countryCode}' : 'en_US';
  return DateFormat('dd MMM yy', languageCode).format(date);
}

String formatDate(BuildContext context, DateTime date, String format) {
  Locale locale = I18n.of(context).locale;
  String languageCode =
      locale != null ? '${locale.languageCode}_${locale.countryCode}' : 'en_US';
  return DateFormat(format, languageCode).format(date);
}
