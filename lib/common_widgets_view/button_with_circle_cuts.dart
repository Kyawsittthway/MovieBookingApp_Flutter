import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import 'interfont_text_widget.dart';

class CircleCutButtonWidget extends StatelessWidget {
  final String buttonName;
  final Function onTapFunction;
  final Color inputColor;

  CircleCutButtonWidget({
    required this.buttonName,
    required this.onTapFunction,
    required this.inputColor
});


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          child: Container(
            height: XL_HEIGHT,
            width: CHECKOUT_PAGE_CONTINUE_BUTTON_WIDTH,
            child: Center(
              child: InterFontTextWidget(
                buttonName,
                color: Colors.black,
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
                color: inputColor),
          ),
          onTap: () {
            onTapFunction();
          },
        ),
        //Right circle cut
        Positioned(
          right: CIRCLE_CUT_RIGHT,
          child: SizedBox(
            height: CIRCLE_CUT_HEIGHT,
            width: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PRIMARY_BACKGROUND_COLOR,
              ),
            ),
          ),
        ),
        //left circle cut
        Positioned(
          left: CIRCLE_CUT_LEFT,
          child: SizedBox(
            height: CIRCLE_CUT_HEIGHT,
            width: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PRIMARY_BACKGROUND_COLOR,
              ),
            ),
          ),
        ),
      ],
    );
  }
}