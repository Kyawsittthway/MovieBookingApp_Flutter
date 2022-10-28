import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/user_info_vo.dart';

class UserInfoDao{
  static final UserInfoDao _singleton = UserInfoDao._internal();

  factory UserInfoDao(){
    return _singleton;
  }

  UserInfoDao._internal();

   void saveUserInfo(UserInfoVO userInfo) async{
     return getUserInfoBox().put(userInfo.id, userInfo);
   }

   UserInfoVO? getUserInfo(int userId) {
     return getUserInfoBox().get(userId);
   }

   ///Reactive Programming
  Stream<void> getAllUserInfoEventStream(){
     return getUserInfoBox().watch();
  }

  Stream<UserInfoVO?> getUserInfoStream(int userId){
     return Stream.value(getUserInfo(userId));
  }







  Box<UserInfoVO> getUserInfoBox(){
    return Hive.box<UserInfoVO>(BOX_NAME_USER_INFO_VO);
  }
}