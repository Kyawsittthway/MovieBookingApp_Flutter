import 'dart:ffi';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/DashTicketSeperator.dart';
import 'package:movie_booking_app/common_widgets_view/dart_time_view_section_widget.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/models/date_time_place_items.dart';
import 'package:movie_booking_app/models/movie_info_item.dart';
import 'package:movie_booking_app/pages/booking_success_page.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:ticket_pass_package/ticket_pass.dart';

import '../currentAppState.dart';
import '../currentAppState.dart';

class TicketConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        title: InterFontTextWidget(
          "Ticket Confirmation",
          fontSize: 20.0,
        ),
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MovieTicketViewSection(),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 90.0,
                width: 90.0,
                child: Image.asset("assets/icons/QR.png"),
              ),
              SizedBox(height: 10.0,),
              InterFontTextWidget(
                "WAG5PL1C",
                fontSize: 20.0,
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InterFontTextWidget(
                    "TPIN : ",
                    color: CINEMA_FEATURES_COLOR,
                    fontSize: 20.0,
                  ),
                  InterFontTextWidget(
                    "WKCSL96",
                    fontSize: 20.0,
                  )
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                  width: 170.0,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: GREEN_BUTTON_COLOR
                    ),
                      onPressed: () async{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  BookingSuccessPage()),
                        );
                        await Future.delayed(const Duration(seconds: 2), (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  HomePage()),
                          );
                        });

                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 24.2,
                          color: Colors.black
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

class MovieTicketViewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 330,
        width: 370,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  TICKET_CONFIRMATION_PAGE_GRADIENT_COLOR1,
                  TICKET_CONFIRMATION_PAGE_GRADIENT_COLOR2,
                  TICKET_CONFIRMATION_PAGE_GRADIENT_COLOR3,
                  TICKET_CONFIRMATION_PAGE_GRADIENT_COLOR4
                ]),
            borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: 96,
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: Image.network(
                    "${CurrentAppState.moviePoster}",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width:KILO_WIDTH,
                            child: InterFontTextWidget(
                              "${CurrentAppState.receipt.movieName}",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InterFontTextWidget(
                            movieInfo.movieFormat,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                      InterFontTextWidget("${CurrentAppState.receipt.cinemaName}",
                          color: GREEN_BUTTON_COLOR,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                      InterFontTextWidget(
                        movieInfo.movieTicketAmount,
                        color: CINEMA_FEATURES_COLOR,
                        fontSize: 14.0,
                      ),
                      Row(
                        children: [
                          InterFontTextWidget(
                            '${CurrentAppState.seatNumber}',
                            fontSize: 16.0,
                          ),
                          InterFontTextWidget(
                            '${movieInfo.movieScreen}',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            DashedTicketSeparator(),
            SizedBox(
              height: 30.0,
            ),
            DateTimePlaceViewSection(inputDateTimePlace: dateTimePlace)
          ],
        ),
      ),
    );
  }
}
