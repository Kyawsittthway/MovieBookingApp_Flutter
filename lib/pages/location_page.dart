import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/data.vos/models/padc_api_model.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';
import 'package:movie_booking_app/data.vos/vos/city_vo.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';
import 'package:movie_booking_app/resources/strings.dart';

import '../data.vos/models/padc_api_model_impl.dart';
import 'home_page.dart';

class LocationPage extends StatefulWidget {
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  // List<String> cities = [
  //   "Yangon",
  //   "Mandalay",
  //   "Nay Pyi Taw",
  //   "Magway",
  // ];
  List<CityVO> cityList = [];
  PadcApiModel padcApiModel = PadcApiModelImpl();
  BaseResponseVO? setCityResponse;
  @override
  void initState(){
    super.initState();

    ///Location
    padcApiModel.getCities().then((city){
      setState(() {
        cityList = city;
      });
    }).catchError((error){
      print("Error occured in fetching city :: ${error}");
    });

    /// Location from Database
    padcApiModel.getCities().then((cities){
      setState(() {

        cityList = cities;
        print("City list from database :: $cityList");
      });
    }).catchError((error){
      print("Error fetching locations from database :: $error");
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    PICK_REGION_TEXT,
                    style: TextStyle(
                      color: GREEN_BUTTON_COLOR,
                      shadows: [
                        Shadow(
                          color: GREEN_BUTTON_COLOR,
                          blurRadius: 30,
                        ),
                      ],
                      fontFamily: DEFAULT_FONT,
                      fontSize: NORMAL_FONT_SIZE_2X,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizeBoxH30(),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                GRADIENT_COMPONENT_COLOR1,
                                GRADIENT_COMPONENT_COLOR2,
                              ]),
                          borderRadius:
                              BorderRadius.circular(BORDER_RADIUS_NORMAL),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            prefixIcon:
                                Icon(Icons.search, color: GREEN_BUTTON_COLOR),
                            labelText: SEARCH_YOUR_LOCATION_TEXT,
                            labelStyle: TextStyle(
                              color: SEARCH_BAR_HINT_TEXT_COLOR,
                              fontFamily: INTER_FONT_FAMILY,
                              fontSize: SMALL_FONT_SIZE_14,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(BORDER_RADIUS_NORMAL),
                          color: GREEN_BUTTON_COLOR,
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              CupertinoIcons.paperplane,
                              size: NAVIGATION_BUTTION_ICON_SIZE,
                              color: NAVIGATION_ICON_COLOR,
                            ),
                            onPressed: () {
                              print("Navigation icon is pressed");
                            },
                          ),
                        ),
                      )
                    ]),
                SizeBoxH30(),
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/icons/cities.png',
                      height: CITY_ICON_HEIGHT,
                      width: CITY_ICON_WIDTH,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 30.0,
                  color: NAVIGATION_ICON_COLOR,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: SMALL_PADDING),
                  child: Text(
                    CITIES_HEADING_TEXT,
                    style: TextStyle(color: CITY_HEADING_COLOR),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Column(
                          children:[
                          ListTile(
                            title: Text(
                              "${cityList[index].name}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                            Divider(color: NAVIGATION_ICON_COLOR,),
                        ]
                        ),
                        onTap: (){
                            padcApiModel.setCities(CurrentAppState.userToken,cityList[index].id ?? 0).then((result){

                              setCityResponse = result;
                              print("Set city response::${setCityResponse?.message}");
                              setState(() {
                                CurrentAppState.currentCityId = cityList[index].id ?? 0;
                                CurrentAppState.currentCityname = cityList[index].name ?? "";

                              });
                              goToHomePage(context);
                            }).catchError((error){
                              print("Error in setting city $error");
                            });
                        },
                      );
                    })
              ],
            ),
          ),
        ));
  }

  void goToHomePage(BuildContext context) {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  HomePage()),
    );
  }
}
