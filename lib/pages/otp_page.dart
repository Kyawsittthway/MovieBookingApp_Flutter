import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/data.vos/vos/user_info_vo.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/pages/location_page.dart';
import 'package:movie_booking_app/persistence/dao/sign_in_response_dao.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widgets_view/size_box_h12.dart';
import '../common_widgets_view/size_box_h30.dart';
import '../data.vos/models/padc_api_model.dart';
import '../data.vos/models/padc_api_model_impl.dart';
import 'home_page.dart';

class OTPpage extends StatelessWidget {
  final String phoneNo;
  OTPpage({required this.phoneNo});
  PadcApiModel padcApiModel = PadcApiModelImpl();
   SignInWithPhoneResponse? signInWithPhoneResponse;
   UserInfoVO? userInfoVO;
  String veriCode = "";
  SignInResponseDao signInResponseDao = SignInResponseDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        body: Container(
          height: double.infinity,
          color: PRIMARY_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    height: 0.0,
                  ),
                ),
                Center(
                  child: Image.asset('assets/icons/loginLogo.png'),
                ),
                SizedBox(
                  height: SPACE_BETWEEN_ICON_AND_TITLE,
                ),
                Text(
                  SENT_OTP_TEXT,
                  style: TextStyle(
                    fontSize: TITLE_FONT_SIZE,
                    color: Colors.white,
                    fontFamily: DEFAULT_FONT,
                  ),
                ),
                SizeBoxH12(),
                Text(
                  ENTER_OTP_TEXT,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: NORMAL_FONT_SIZE_2X,
                    color: Colors.grey,
                    fontFamily: DEFAULT_FONT,
                  ),
                ),
                SizeBoxH30(),
                Text(
                  OTP_HINT_TEXT,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizeBoxH30(),
                OtpTextField(
                  numberOfFields: 6,
                  fillColor: Colors.white,
                  filled: true,
                  fieldWidth: 50,
                  borderColor: Colors.white,
                  showFieldAsBox: true,
                  focusedBorderColor: Colors.black,
                  onCodeChanged: (String code) {
                    print(code);
                  },
                  onSubmit: (String verificationCode) {
                    veriCode = verificationCode;


                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text("Verification Code"),
                    //         content: Text("Code entered is $verificationCode"),
                    //       );
                    //     });
                  },
                ),
                SizeBoxH30(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      NO_OTP_TEXT,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 1.0,
                    ),
                    InkWell(
                        child: Text(
                          RESEND_CODE_TEXT,
                          style: TextStyle(color: GREEN_BUTTON_COLOR),
                        ),
                        onTap: () {
                          print("Resend is pressed");
                        }),
                  ],
                ),
                SizeBoxH30(),
                Container(
                  width: LOGIN_VIEW_BUTTON_WIDTH,
                  child: ElevatedButton(
                    onPressed: () async{
                      final prefs = await SharedPreferences.getInstance();
                      padcApiModel.getUserInfoFromDatabase(phoneNo, veriCode).listen((response) async {
                        // signInWithPhoneResponse = response;
                        // print("verification code :: $veriCode & phoneNumber::$phoneNo");
                        // print("Response from api :: ${signInWithPhoneResponse?.code}");
                        // userInfoVO = response?.data;
                        // print("Name of the user ${userInfoVO?.toJson()} ");
                        if(response?.code == 201){
                          CurrentAppState.userToken = "Bearer ${response?.token}";
                          print("setting token in otp :: ${response?.token}");
                          await prefs.setInt("userId", response?.data?.id ?? 0);

                          // signInResponseDao.saveUserInfo(signInWithPhoneResponse!);
                          // print("user value from db :: ${signInResponseDao.getUserInfoBox()}");
                          navigateToLocationPage(context);
                        }

                      }).onError((error){
                        print("Sign in with phone Error :: ${error}");
                      });

                    },
                    style: ElevatedButton.styleFrom(
                        primary: GREEN_BUTTON_COLOR, onPrimary: Colors.black),
                    child: Text(
                      CONFIRM_OTP_BUTTON_TEXT,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            color: PRIMARY_BACKGROUND_COLOR,
            child: Text(
              LOGIN_PAGE_FOOTER_TEXT,
              style: TextStyle(color: LOGIN_FOOTER_TEXT_COLOR),
            ),
          ),
        ));
  }

  void navigateToLocationPage(BuildContext context) {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  LocationPage()),
    );
  }
}
