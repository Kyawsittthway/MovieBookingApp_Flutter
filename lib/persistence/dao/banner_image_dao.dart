import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/city_vo.dart';
import '../../data.vos/vos/user_info_vo.dart';

class BannerImageDao{
  static final BannerImageDao _singleton = BannerImageDao._internal();

  factory BannerImageDao(){
    return _singleton;
  }

  BannerImageDao._internal();

  void saveAllBannerImages(List<BannerImageVO>bannerList) async{
    Map<int,BannerImageVO> bannerMap = Map.fromIterable(bannerList,key: (banner)=>banner.id,value:(banner)=>banner);
    await getBannerImageBox().putAll(bannerMap);
  }

  List<BannerImageVO> getAllBanners(){
    return getBannerImageBox().values.toList();
  }


  Box<BannerImageVO> getBannerImageBox(){
    return Hive.box<BannerImageVO>(BOX_NAME_BANNER_IMAGE_VO);
  }
}