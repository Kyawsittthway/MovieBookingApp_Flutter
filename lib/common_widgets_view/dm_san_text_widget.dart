import 'package:flutter/material.dart';

import '../resources/fonts.dart';

class DmSanTextWidget extends StatelessWidget {

  late String content;
  late FontStyle fontStyle;
  late FontWeight fontWeight;
  late double fontSize;
  late Color color;

  DmSanTextWidget(
      @required this.content,
      {
        this.fontStyle = FontStyle.normal,
        this.fontSize = NORMAL_FONT_SIZE_2X,
        this.fontWeight = FontWeight.w700,
        this.color = Colors.white,
      }
      );

  @override
  Widget build(BuildContext context) {
    return Text(content, style: TextStyle(
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color:color,
      fontFamily: DEFAULT_FONT,
    ),);
  }
}