import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime? dateSelected) {
  if(dateSelected == null) return "";
  var date = "";

  if (dateSelected.day != DateTime.now().day) {
    date = DateFormat("hh:mm a, dd/MM").format(dateSelected);
  } else {
    date = DateFormat("hh:mm a").format(dateSelected);
  }
  return date;
}

String formatTime(BuildContext context, TimeOfDay? timeSelected) {
  if(timeSelected == null) return "";
  var time = "";
  var localization = MaterialLocalizations.of(context);
  time = localization.formatTimeOfDay(timeSelected);

  return time;
}

String formatOrderDateTime(String? date, String? time) {
  var inputDate = DateFormat("MM/dd/yyyy hh:mm a").parse("$date $time");
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(inputDate);
}