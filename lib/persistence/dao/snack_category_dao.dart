import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/snack_category_vo.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/city_vo.dart';
import '../../data.vos/vos/user_info_vo.dart';

class SnackCategoryDao{
  static final SnackCategoryDao _singleton = SnackCategoryDao._internal();

  factory SnackCategoryDao(){
    return _singleton;
  }

  SnackCategoryDao._internal();

  void saveAllSnackCategories(List<SnackCategoryVO>snackCategoryList) async{
    Map<int,SnackCategoryVO> snackMap = Map.fromIterable(snackCategoryList,key: (category)=>category.id,value:(category)=>category);
    await getSnackCategoryBox().putAll(snackMap);
  }

  List<SnackCategoryVO> getAllSnackCategories(){
    return getSnackCategoryBox().values.toList();
  }

  ///Reactive Programming
  Stream<void> getSnackCategoryEvents(){
    return getSnackCategoryBox().watch();
}
  Stream<List<SnackCategoryVO>> getAllSnackCategoriesStream(){
    return Stream.value(getAllSnackCategories());
  }

  Box<SnackCategoryVO> getSnackCategoryBox(){
    return Hive.box<SnackCategoryVO>(BOX_NAME_SNACK_CATEGORY_VO);
  }
}