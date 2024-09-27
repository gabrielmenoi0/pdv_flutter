import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  String get toFormatted => DateFormat("dd/MM/yyyy", "pt_BR").format(this);
  String get toFormattedTable {
    final DateFormat formatter = DateFormat("EEEE, dd 'de' MMMM 'de' y", "pt_BR");
    return formatter.format(this);
  }
    String get toFormattedLong => DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY, "pt_BR").format(this);
}

extension TimeOfDayExtension on TimeOfDay {
  String get toFormatted => "$hour:$minute";
}