import 'package:flutter/material.dart';
import 'package:movie_booking_app/currentAppState.dart';

class DateTimePlace{
  final IconData dateIcon,timeIcon,placeIcon;
  final String dateInput,timeInput,placeInput;

  DateTimePlace(
  {
   required this.dateIcon,
    required this.timeIcon,
    required this.placeIcon,
    required this.dateInput,
    required this.timeInput,
    required this.placeInput

});

}

DateTimePlace dateTimePlace = DateTimePlace(dateIcon: Icons.calendar_today_rounded, timeIcon: Icons.watch_later_outlined, placeIcon: Icons.location_on, dateInput: CurrentAppState.receipt.date ?? "d", timeInput: CurrentAppState.receipt.time ?? "d", placeInput: CurrentAppState.receipt.location ?? "d")
;