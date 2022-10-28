import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_time_slot_status_vo.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/city_vo.dart';
import '../../data.vos/vos/user_info_vo.dart';

class CinemaTimeslotDao{
  static final CinemaTimeslotDao _singleton = CinemaTimeslotDao._internal();

  factory CinemaTimeslotDao(){
    return _singleton;
  }

  CinemaTimeslotDao._internal();

  void saveAllCinemaTimeslots(List<CinemaTimeslotVO>cinemaTimeslotList,String dateKey) async{

    await getCinemaTimeslotBox().put(dateKey,cinemaTimeslotList);
  }

  List<CinemaTimeslotVO>? getAllCinemaTimeslotByDateKey(String dateKey){
    return getCinemaTimeslotBox().get(dateKey,defaultValue: [])?.cast<CinemaTimeslotVO>();
  }

  ///Reactive Programming
  Stream<void> getAllCinemaTimeslotsEvents(){
    return getCinemaTimeslotBox().watch();
  }

  Stream<List<CinemaTimeslotVO>?> getAllCinemaTimeslotByDateKeyStream(String dateKey){
    return Stream.value(getAllCinemaTimeslotByDateKey(dateKey));
  }


  Box<List<CinemaTimeslotVO>> getCinemaTimeslotBox(){
    return Hive.box<List<CinemaTimeslotVO>>(BOX_NAME_CINEMA_TIMESLOT_VO);
  }
}