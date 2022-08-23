import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';

class WelcomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: PRIMARY_BACKGROUND_COLOR,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:Center(child: Image.asset('assets/Logo.png')),


            
            
          ),

        ],
      )
    );
  }
}
