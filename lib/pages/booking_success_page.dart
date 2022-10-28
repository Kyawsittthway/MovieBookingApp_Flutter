import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';

class BookingSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: BOOKING_SUCCESS_PAGE_BACKGROUND_COLOR,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(child: Container()),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: BOOKING_SUCCESS_PAGE_IMAGE_BOTTOM_PADDING),
              child: Image.asset("assets/icons/booking_success.png"),
            ),
          ],
        ),
      ),
    );
  }
}
