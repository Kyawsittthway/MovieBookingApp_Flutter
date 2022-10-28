import 'package:flutter/material.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_vo.dart';

class Utils{
  static Map<int?,Color?> idToStatus = {};

  static CinemaVO cinemaVO = CinemaVO(1, "name", "phone", "email", "address", "promoVideoURL", [], [""]);
}