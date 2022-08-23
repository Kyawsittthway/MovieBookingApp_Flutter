import 'package:flutter/material.dart';

import '../resources/fonts.dart';

class InterFontTextWidget extends StatelessWidget {

  late String content;
  late FontStyle fontStyle;
  late FontWeight fontWeight;
  late double fontSize;
  late Color color;
  late TextAlign align;

  InterFontTextWidget(
      @required this.content,
      {
        this.fontStyle = FontStyle.normal,
        this.fontSize = NORMAL_FONT_SIZE_2X,
        this.fontWeight = FontWeight.w700,
        this.color = Colors.white,
        this.align = TextAlign.left,
      }
      );

  @override
  Widget build(BuildContext context) {
    return Text(content,
      textAlign: align,
      style: TextStyle(
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color:color,
      fontFamily: INTER_FONT_FAMILY,

    ),);
  }
}