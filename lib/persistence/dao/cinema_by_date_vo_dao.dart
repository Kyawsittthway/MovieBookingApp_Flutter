import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_by_date_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_time_slot_status_vo.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/city_vo.dart';
import '../../data.vos/vos/user_info_vo.dart';

class CinemaByDateDao{
  static final CinemaByDateDao _singleton = CinemaByDateDao._internal();

  factory CinemaByDateDao(){
    return _singleton;
  }

  CinemaByDateDao._internal();

  void saveAllCinemaByDate(List<CinemaByDateVO>cinemaByDateList,String dateKey) async{

    await getCinemaTimeslotBox().put(dateKey,cinemaByDateList);
  }

  List<CinemaByDateVO>? getAllCinemaByDateWithDatekey(String dateKey){
    return getCinemaTimeslotBox().get(dateKey,defaultValue: [])?.cast<CinemaByDateVO>();
  }

  ///Reactive Programming
  Stream<void> getAllCinemaByDateWithDateKeyEvents() {
    return getCinemaTimeslotBox().watch();
  }

  Stream<List<CinemaByDateVO>?> getAllCinemaByDateWithDateKeyStream(String dateKey){
    return Stream.value(getAllCinemaByDateWithDatekey(dateKey));
  }

  Box<List> getCinemaTimeslotBox(){
    return Hive.box<List>(BOX_NAME_CINEMA_BY_DATE_VO);
  }
}