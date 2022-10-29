import 'package:hive/hive.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/user_info_vo.dart';

///insert user vo only
class SignInResponseDao{
  static final SignInResponseDao _singleton = SignInResponseDao._internal();

  factory SignInResponseDao(){
    return _singleton;
  }

  SignInResponseDao._internal();

  void saveUserInfo(SignInWithPhoneResponse signInWithPhoneResponse) async{
    return getUserInfoBox().put(signInWithPhoneResponse.data?.id, signInWithPhoneResponse);
  }



  SignInWithPhoneResponse? getUserInfo(){
    if(getUserInfoBox().values.isEmpty == true){
      return null;
    }else {
      return getUserInfoBox().values.first;
    }
  }

  ///Reactive Programming
  Stream<void> getUserInfoBoxEvents(){
    return getUserInfoBox().watch();
  }

  Stream<SignInWithPhoneResponse?> getUserInfoStream(){
    return Stream.value(getUserInfo());
  }


  Box<SignInWithPhoneResponse> getUserInfoBox(){
    return Hive.box<SignInWithPhoneResponse>(BOX_NAME_SIGN_IN_RESPONSE);
  }
}