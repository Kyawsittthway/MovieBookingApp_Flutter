import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data.vos/vos/user_info_persistence_vo.dart';
import 'package:movie_booking_app/pages/login_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data.vos/models/padc_api_model.dart';
import '../data.vos/models/padc_api_model_impl.dart';
import '../network/responses/sign_in_with_phone_response.dart';
import 'home_page.dart';

class WelcomePage extends StatefulWidget {


  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  PadcApiModel padcApiModel = PadcApiModelImpl();
  UserInfoPersistenceVO? userInfo;
  late Future<bool> loginCheckFuture;

  @override
  void inistState() {
    super.initState();



    Timer(Duration(seconds: 5),()async{
      int userId = await getUserId();
      padcApiModel.getUserInfoFromDatabaseNoParameter(userId).listen((info) {

          userInfo = info;
          print("User info from database :: $userInfo");
          if(userInfo == null){
            print("Hi it is null");
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
          }
      }).onError((error) {
        print("error fetching user info from databsae :: $error");
      });
      // if(userInfo == null){
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
      // }else{
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
      // }
    });
  }

  Future<int> getUserId()async{
  final prefs = await SharedPreferences.getInstance();
  int id = prefs.getInt('userId') ?? 0;
  return id;
}



  @override
  Widget build(BuildContext context) {
    print("User info from database :: $userInfo");

    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: PRIMARY_BACKGROUND_COLOR,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:Center(child: Image.asset('assets/icons/Logo.png')),




          ),

        ],
      )
    );
  }
}
