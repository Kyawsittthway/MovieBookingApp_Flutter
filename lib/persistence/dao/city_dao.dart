import 'package:hive/hive.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/city_vo.dart';
import '../../data.vos/vos/user_info_vo.dart';

class CityDao{
  static final CityDao _singleton = CityDao._internal();

  factory CityDao(){
    return _singleton;
  }

  CityDao._internal();

  void saveAllCities(List<CityVO>cityList) async{
    Map<int,CityVO> cityMap = Map.fromIterable(cityList,key: (city)=>city.id,value:(city)=>city);
    await getCityBox().putAll(cityMap);
  }

  List<CityVO> getAllCities(){
    return getCityBox().values.toList();
  }


  Box<CityVO> getCityBox(){
    return Hive.box<CityVO>(BOX_NAME_CITY_VO);
  }
}