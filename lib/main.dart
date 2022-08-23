import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/checkout_page.dart';
import 'package:movie_booking_app/pages/chose_time_cinema.dart';
import 'package:movie_booking_app/pages/food_and_beverage_page.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/pages/location_page.dart';
import 'package:movie_booking_app/pages/login_page.dart';
import 'package:movie_booking_app/pages/movie_detail_page.dart';
import 'package:movie_booking_app/pages/movie_search_page.dart';
import 'package:movie_booking_app/pages/otp_page.dart';
import 'package:movie_booking_app/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        home: CheckOutPage()
    );
  }
}




