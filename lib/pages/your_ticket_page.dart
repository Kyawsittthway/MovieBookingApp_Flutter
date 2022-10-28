import 'dart:ffi';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/DashTicketSeperator.dart';
import 'package:movie_booking_app/common_widgets_view/dart_time_view_section_widget.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/models/date_time_place_items.dart';
import 'package:movie_booking_app/models/movie_info_item.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:ticket_pass_package/ticket_pass.dart';

class YourTicketPage extends StatelessWidget {
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
                    "https://upload.wikimedia.org/wikipedia/en/d/db/Emily_%282022_film%29_poster.png",
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
                          InterFontTextWidget(
                            movieInfo.movieName,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                          ),
                          InterFontTextWidget(
                            movieInfo.movieFormat,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                      InterFontTextWidget(movieInfo.moviePlace,
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
                            '${movieInfo.movieSeat}',
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
