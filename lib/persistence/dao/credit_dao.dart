import 'package:hive/hive.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/city_vo.dart';
import '../../data.vos/vos/credit_vo.dart';
import '../../data.vos/vos/user_info_vo.dart';

class CreditDao{
  static final CreditDao _singleton = CreditDao._internal();

  factory CreditDao(){
    return _singleton;
  }

  CreditDao._internal();

  void saveAllCreditsByMovieId(List<CreditVO>creditList, int movieId) async{
    // Map<int,List<CreditVO>> creditMap = Map.fromIterable(creditList,key: (movie)=>movieId,value:(creidt)=>creidt);
    // await getCreditBox().putAll(creditMap);
    await getCreditBox().put(movieId, creditList).catchError((error){
      print("error saving credit in movie detail :: $error");
    });

  }


  List<CreditVO>? getCreditsListByMovieId(int movieId) {
    print(" SHeesh :: ${getCreditBox().get(movieId)}");
    return  getCreditBox().get(movieId,defaultValue: [])?.cast<CreditVO>();
  }

  /// Reactive Programming


  Stream<void> getAllCreditsEventStream(){
    return getCreditBox().watch();
  }

  Stream<List<CreditVO>?> getCreditListByMovieId(int movieId){
    return Stream.value(getCreditsListByMovieId(movieId));
  }


  Box<List> getCreditBox(){
    return Hive.box<List>(BOX_NAME_CREDIT_VO);
  }
}