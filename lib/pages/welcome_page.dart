import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/login_page.dart';
import 'package:movie_booking_app/resources/colors.dart';

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
  SignInWithPhoneResponse? userInfo;
  late Future<bool> loginCheckFuture;

  @override
  void inistState() {
    super.initState();



    Timer(Duration(seconds: 5),(){
      padcApiModel.getUserInfoFromDatabaseNoParameter().then((info) {

          userInfo = info;
          print("User info from database :: $userInfo");
          if(userInfo == null){
            print("Hi it is null");
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
          }
      }).catchError((error) {
        print("error fetching user info from databsae :: $error");
      });
      // if(userInfo == null){
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
      // }else{
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
      // }
    });
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
