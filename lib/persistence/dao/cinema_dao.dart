import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/cinema_vo.dart';
import '../../data.vos/vos/city_vo.dart';
import '../../data.vos/vos/user_info_vo.dart';

class CinemaDao{
  static final CinemaDao _singleton = CinemaDao._internal();

  factory CinemaDao(){
    return _singleton;
  }

  CinemaDao._internal();

  void saveAllCinema(List<CinemaVO>cinemaList) async{
    Map<int,CinemaVO> cinemaMap = Map.fromIterable(cinemaList,key: (cinema)=>cinema.id,value:(cinema)=>cinema);
    await getCinemaBox().putAll(cinemaMap);
  }

  List<CinemaVO> getAllCinema(){
    return getCinemaBox().values.toList();
  }


  Box<CinemaVO> getCinemaBox(){
    return Hive.box<CinemaVO>(BOX_NAME_CINEMA_VO);
  }
}