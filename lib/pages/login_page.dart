import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_r12.dart';
import 'package:movie_booking_app/data.vos/models/padc_api_model.dart';
import 'package:movie_booking_app/data.vos/models/padc_api_model_impl.dart';
import 'package:movie_booking_app/network/responses/get_otp_response.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/pages/otp_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';
import 'package:movie_booking_app/resources/strings.dart';

import '../common_widgets_view/size_box_h12.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var countryCodes = [
    "+95",
  ];
  final phoneNoTextFieldController = TextEditingController();
  PadcApiModel otpModel = PadcApiModelImpl();
  late GetOTPResponse getOTPresponse;



  @override
  void initState(){
    super.initState();
    // otpModel.getUserInfoFromDatabase().then((info){
    //   setState(() {
    //     userInfo = info;
    //     print("User infos :: ${userInfo?.toJson()}");
    //
    //   });
    // }).catchError((error){
    //   print("Error fetching user info from db :: $error");
    // });
  }

  @override
  Widget build(BuildContext context) {
    String? dropDownValue = countryCodes[0];
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: PRIMARY_BACKGROUND_COLOR,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(
                  child: Container(
                height: 0.0,
              )),
              Container(
                child: Image.asset('assets/icons/loginLogo.png'),
              ),
              SizedBox(
                height: 96,
              ),
              Text(
                VERIFY_PHONE_NUMBER,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: TITLE_FONT_SIZE,
                  fontFamily: DEFAULT_FONT,
                ),
              ),
              SizeBoxH12(),
              Text(
                SEND_DIGIT_CODE,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: NORMAL_FONT_SIZE_2X,
                    fontFamily: DEFAULT_FONT),
              ),
              SizeBoxH12(),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 75,
                      child: Center(
                        child: DropdownButton(
                        style: TextStyle(
                        color: Colors.white,
                          fontSize: SMALL_FONT_SIZE_14
                          ),
                          dropdownColor: Colors.black,
                          value: dropDownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                              print(dropDownValue);
                            });
                          },
                          items: countryCodes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: dropDownValue,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: Colors.white,

                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizeBoxR12(),
                    Container(
                        width: 200,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneNoTextFieldController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border:UnderlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),

                            hintText: MOBILE_PHONE_HINT_TEXT,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ))
                  ]),
              SizeBoxH30(),
              Container(
                width: LOGIN_VIEW_BUTTON_WIDTH,
                child: ElevatedButton(
                    child: Text(VERIFY_PHONE_NUMBER),
                    onPressed: () {
                      String fullPhNo = "$dropDownValue${phoneNoTextFieldController.text}";
                      String refinedPhNo = fullPhNo.substring(1,fullPhNo.length);
                      // navigateToOTPpage(context);
                      print("Value in the text :: ${phoneNoTextFieldController.text}");
                     otpModel.getOTPResponse(refinedPhNo).then((otpResponse){
                       getOTPresponse = otpResponse;
                       if(getOTPresponse.code == 200){

                         navigateToOTPpage(context,refinedPhNo);
                       }
                     }).catchError((error){
                       print(error);
                     });

                    },
                    style: ElevatedButton.styleFrom(
                        primary: GREEN_BUTTON_COLOR, onPrimary: Colors.black)),
              ),
              SizeBoxH30(),
              Container(
                width: LOGIN_VIEW_BUTTON_WIDTH,
                child: ElevatedButton(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.g_mobiledata),
                    Text(CONTINUE_WITH_GOOGLE_TEXT),
                  ]),
                  onPressed: () {
                    //navigateToHomePage(context);

                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white, onPrimary: Colors.black),
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
      ),
    );
  }

  void navigateToOTPpage(BuildContext context,String phoneNo) {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  OTPpage(phoneNo: phoneNo,)),
    );
  }

  void navigateToHomePage(BuildContext context) {
       Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  HomePage()),
    );
  }
}
