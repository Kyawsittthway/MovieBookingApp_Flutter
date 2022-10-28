import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/profile_menu_properties.dart';

import '../resources/strings.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ///Top background drop section
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Image.asset(
                      "assets/icons/profile_bgdrop.png",
                      fit: BoxFit.cover,
                    )),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/icons/profile_icon.png",
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: SMALL_PADDING),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: GREEN_BUTTON_COLOR),
                            primary: Colors.transparent,
                          ),
                          child: Text(
                            LOGIN_BTN_TEXT,
                            style: TextStyle(color: GREEN_BUTTON_COLOR),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: LARGE_PADDING,
              ),
              ProfileMenuItems(inputMenuName: purchaseHistoryMenuText, inputIconPath: purchaseHistoryIconPath, inputOnTap: (){},),
              ProfileMenuItems(inputMenuName: offerMenuText, inputIconPath: offerIconPath, inputOnTap: (){},),
              ProfileMenuItems(inputMenuName: giftCardMenuText, inputIconPath: giftCardIconPath, inputOnTap: (){},),
              ProfileMenuItems(inputMenuName: locationMenuText, inputIconPath: locationIconPath, inputOnTap: (){},),
              ProfileMenuItems(inputMenuName: paymentMenuText, inputIconPath: paymentIconPath, inputOnTap: (){},),
              ProfileMenuItems(inputMenuName: helpAndSupportMenuText, inputIconPath: helpAndSupportIconPath, inputOnTap: (){},),
              ProfileMenuItems(inputMenuName: logoutMenuText, inputIconPath: logoutIconPath, inputOnTap: (){},),



            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuItems extends StatelessWidget {
   ProfileMenuItems({
    required this.inputMenuName,
     required this.inputIconPath,
     required this.inputOnTap
  });
  final String inputMenuName;
  final String inputIconPath;
  final Function inputOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileMenuIconText(menuName: inputMenuName, iconPath: inputIconPath,),
                Icon(
                  Icons.chevron_right,
                  color: DOTTED_LINE_COLOR1,
                  size: NORMAL_ICON_SIZE,
                ),
              ],
            ),
            SizedBox(height: SMALL_PADDING_2X,),
            Divider(color: DIVIDER_COLOR1,)
          ],
        ),
      ),
    );
  }
}

class ProfileMenuIconText extends StatelessWidget {
   ProfileMenuIconText({
    required this.iconPath,
    required this.menuName
  });
  final String iconPath;
  final String menuName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          AssetImage(
           iconPath,
          ),
          color: Colors.white,
        ),
        SizedBox(
          width: SMALL_PADDING,
        ),
        InterFontTextWidget(menuName)
      ],
    );
  }
}
