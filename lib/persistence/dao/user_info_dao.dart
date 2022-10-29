import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/user_info_persistence_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/user_info_vo.dart';

class UserInfoDao{
  static final UserInfoDao _singleton = UserInfoDao._internal();

  factory UserInfoDao(){
    return _singleton;
  }

  UserInfoDao._internal();

   void saveUserInfo(UserInfoPersistenceVO userInfo) async{
     print("user info id from save user info :: ${userInfo.id} type:: ${userInfo.runtimeType}");
     return getUserInfoBox().put(userInfo.id, userInfo);
   }

   UserInfoPersistenceVO? getUserInfo(int userId) {
     return getUserInfoBox().get(userId);
   }

   ///Reactive Programming
  Stream<void> getAllUserInfoEventStream(){
     return getUserInfoBox().watch();
  }

  Stream<UserInfoPersistenceVO?> getUserInfoStream(int userId){
     return Stream.value(getUserInfo(userId));
  }







  Box<UserInfoPersistenceVO> getUserInfoBox(){
    return Hive.box<UserInfoPersistenceVO>(BOX_NAME_USER_INFO_PERSISTENCE_VO);
  }
}