import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/fonts.dart';
import 'interfont_text_widget.dart';

class CustomChipView extends StatelessWidget {
  CustomChipView({
    required this.genreList,
    required this.chipHeight,
    required this.chipWidth,
    required this.isCenter
  });

  final List<String> genreList;
  final double chipHeight;
  final double chipWidth;
  final bool isCenter;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: SMALL_PADDING,
      runSpacing: SMALL_PADDING,
      children: genreList
          .map((genre) => GenreChipView(
        genre: genre, width: chipWidth,height:chipHeight, isCenter: isCenter ,
      ))
          .toList(),
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genre;
  final double width;
  final double height;
  final bool isCenter;
  GenreChipView({required this.genre, required this.width, required this.height,required this.isCenter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCenter== true ? width : null,
      height: isCenter == true ? height : 20,
      child: Container(

        decoration: BoxDecoration(
          color: GREEN_BUTTON_COLOR,
          borderRadius: isCenter==true ? BorderRadius.circular(BORDER_RADIUS_NORMAL) : BorderRadius.circular(BORDER_RADIUS_SMALL),
          boxShadow: [
            BoxShadow(color: GREEN_BUTTON_COLOR, blurRadius: 1.0)
          ],
        ),
        child: isCenter==true? Center(
            child: InterFontTextWidget(
              genre,
              fontSize: NORMAL_FONT_SIZE,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )):Padding(
          padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
              child: InterFontTextWidget(
          genre,
          fontSize: NORMAL_FONT_SIZE,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
            ),
      ),
    );
  }
}