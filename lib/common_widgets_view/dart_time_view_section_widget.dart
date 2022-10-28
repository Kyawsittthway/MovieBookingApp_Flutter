import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/date_time_place_items.dart';
import '../resources/colors.dart';
import '../resources/fonts.dart';

class DateTimePlaceViewSection extends StatelessWidget {
  const DateTimePlaceViewSection({
    required this.inputDateTimePlace
  }) ;
  final DateTimePlace inputDateTimePlace;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DateTimePlaceViewWidget(inputIcon: inputDateTimePlace.dateIcon,content:inputDateTimePlace.dateInput,),
          SizedBox(
            width: 10.0,
          ),
          DateTimePlaceViewWidget(inputIcon: inputDateTimePlace.timeIcon,content:inputDateTimePlace.timeInput,),
          SizedBox(
            width: 10.0,
          ),
          DateTimePlaceViewWidget(inputIcon: inputDateTimePlace.placeIcon,content:inputDateTimePlace.placeInput),

        ],
      ),
    );
  }
}

class DateTimePlaceViewWidget extends StatelessWidget {
   DateTimePlaceViewWidget({
    required this.inputIcon,
    required this.content
  });
  final IconData inputIcon;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(inputIcon,color: GREEN_BUTTON_COLOR,),
        SizedBox(
          height: 10.0,
        ),
        Container(
          width: 110,
          child: Text(content,textAlign: TextAlign.center,style: TextStyle(
            color: Colors.white,
            fontSize: NORMAL_FONT_SIZE,

          ),),
        ),
      ],
    );
  }
}