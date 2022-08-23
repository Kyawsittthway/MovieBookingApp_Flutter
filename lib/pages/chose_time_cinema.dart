import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_r12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_r6.dart';
import 'package:movie_booking_app/pages/food_and_beverage_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';

import '../resources/strings.dart';

class ChooseTimeCinema extends StatefulWidget {
  @override
  State<ChooseTimeCinema> createState() => _ChooseTimeCinemaState();
}

class _ChooseTimeCinemaState extends State<ChooseTimeCinema> {
  List<String> format = ["2D", "3D", "3D IMAX", "3D DEBOX"];

  List<String> cinemas = [
    "Mingalar Cinema Gold Class",
    "JGVC:Junction City",
    "JGVC:City Mall",
    "Mingalar Cinema Gold Class",
    "JGVC:Junction City",
    "JGVC:City Mall"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: MEDIUM_ICON_SIZE,
          ),
          onPressed: () {},
        ),
        actions: [
          Icon(CupertinoIcons.paperplane),
          Padding(
            padding: EdgeInsets.only(top: SMALL_PADDING_15),
            child: InterFontTextWidget("Yangon", fontStyle: FontStyle.italic),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_off_outlined),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              DayView(),
              FormatChipView(format: format),
              IndicatorViews(),
              TimeSlotSection(cinemas: cinemas)
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSlotSection extends StatelessWidget {
  const TimeSlotSection({
    Key? key,
    required this.cinemas,
  }) : super(key: key);

  final List<String> cinemas;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
      height: 350,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: cinemas.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpandablePanel(
              header: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 0.5),
                )),
                child: CinemaFeaturesVisibleView(
                    cinemas: cinemas, index: index),
              ),
              collapsed: Container(
                height: 0,
              ),
              expanded: Column(
                children:[ Container(
                  height: 255,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 5,
                      itemBuilder: (BuildContext context,int index){
                        return InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context)=>Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.6,
                                width:  MediaQuery.of(context).size.width * 0.85,
                                padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING,vertical: SMALL_PADDING),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
                                  color:Colors.black
                                ),
                                child: Column(

                                  children: [
                                    InterFontTextWidget("Term and Conditions"),
                                    SizeBoxH12(),
                                    InterFontTextWidget(
                                       TC,fontWeight: FontWeight.w400,fontSize: NORMAL_FONT_SIZE,
                                    ),
                                    SizeBoxH12(),
                                    Container(
                                      height: 75,
                                      width: 101,
                                      child: Image.asset("assets/icons/term_condition_icon.png"),
                                    ),
                                    SizeBoxH12(),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(onPressed: (){}, child: Text("Cancel",style: TextStyle(color: GREEN_BUTTON_COLOR),),style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          side: BorderSide(color: GREEN_BUTTON_COLOR,)

                                        ),),
                                        ElevatedButton(onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) =>  FoodAndBeveragePage()),
                                          );
                                        }, child: Text("Accept",style: TextStyle(color: Colors.black)),style: ElevatedButton.styleFrom(
                                          primary: GREEN_BUTTON_COLOR
                                        ),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(SMALL_PADDING),
                            padding: EdgeInsets.all(MICRO_PADDING),
                            decoration: BoxDecoration(
                              border: Border.all(color: GREEN_BUTTON_COLOR,width: 2.0)
                            ),
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InterFontTextWidget("12:30 PM",fontSize: SMALL_FONT_SIZE_14,fontWeight: FontWeight.w600,),
                              InterFontTextWidget("3D IMAX",fontSize: NORMAL_FONT_SIZE,fontWeight: FontWeight.w600,),
                              InterFontTextWidget("Screen 2",fontSize: NORMAL_FONT_SIZE,fontWeight: FontWeight.w600,),
                              InterFontTextWidget("20 Available",fontSize: NORMAL_FONT_SIZE,fontWeight: FontWeight.w600,),

                            ],
                              ),
                          ),
                        );
                      }),
                ),
                  Container(
                    margin: EdgeInsets.only(bottom: SMALL_PADDING),
                    child: Row(
                      children: [
                        Icon(Icons.info,color: CINEMA_FEATURES_COLOR,size:15,),
                        SizeBoxR6(),
                        Text("Long press on show timing to see seat class!",style: TextStyle(
                          color: CINEMA_FEATURES_COLOR,
                          fontSize:SMALL_FONT_SIZE_14,
                        ),)
                      ],
                    ),
                  )
              ]
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                tapBodyToExpand: true,
                hasIcon: true,
              ),
            );
          }),
    );
  }
}

class FormatChipView extends StatelessWidget {
  const FormatChipView({
    Key? key,
    required this.format,
  }) : super(key: key);

  final List<String> format;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: SMALL_PADDING),
      margin: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: format.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(right: SMALL_PADDING_15),
              height: 30.0,
              width: 80.0,
              decoration: BoxDecoration(
                  color: CINEMA_FORMAT_CHIP_COLOR,
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius:
                      BorderRadius.circular(BORDER_RADIUS_NORMAL)),
              child: Center(
                  child: InterFontTextWidget("${format[index]}")),
            );
          }),
    );
  }
}

class DayView extends StatelessWidget {
  const DayView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: SMALL_PADDING),
      margin: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
      height: 150,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(10.0),
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                  color: GREEN_BUTTON_COLOR,
                  borderRadius:
                      BorderRadius.circular(BORDER_RADIUS_NORMAL),
                  boxShadow: [
                    BoxShadow(
                      color: GREEN_BUTTON_COLOR,
                      blurRadius: NORMAL_BLUR_RADIUS,
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InterFontTextWidget(
                    "Today",
                    color: Colors.black,
                    fontSize: SMALL_FONT_SIZE_14,
                  ),
                  InterFontTextWidget(
                    "May",
                    color: Colors.black,
                    fontSize: SMALL_FONT_SIZE_14,
                  ),
                  InterFontTextWidget(
                    "8",
                    color: Colors.black,
                    fontSize: SMALL_FONT_SIZE_14,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class CinemaFeaturesVisibleView extends StatelessWidget {
  CinemaFeaturesVisibleView({
    required this.index,
    required this.cinemas,
  });

  final List<String> cinemas;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InterFontTextWidget(
              "${cinemas[index]}",
              fontSize: NORMAL_FONT_SIZE_2X,
              fontWeight: FontWeight.w600,
            ),
            GestureDetector(
              child: Text(
                "See Detail",
                style: TextStyle(
                  color: GREEN_BUTTON_COLOR,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
        SizeBoxH30(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CinemaFeatureView(
              inputIcon: Icons.local_parking,
              inputName: "Parking",
            ),
            SizeBoxR6(),
            CinemaFeatureView(
              inputIcon: Icons.fastfood,
              inputName: "Online Food",
            ),
            SizeBoxR6(),
            CinemaFeatureView(
              inputIcon: Icons.wheelchair_pickup,
              inputName: "Wheel Chair",
            )
          ],
        ),
        SizeBoxH12(),
      ],
    );
  }
}

class CinemaFeatureView extends StatelessWidget {
  const CinemaFeatureView({required this.inputName, required this.inputIcon});

  final String inputName;
  final IconData inputIcon;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        inputIcon,
        size: SMALL_ICON_SIZE,
        color: CINEMA_FEATURES_COLOR,
      ),
      SizeBoxR6(),
      Text(
        inputName,
        style: TextStyle(
          color: CINEMA_FEATURES_COLOR,
          fontFamily: "Inter",
          fontSize: SMALL_FONT_SIZE_14,
        ),
      )
    ]);
  }
}

class IndicatorViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(top: SMALL_PADDING),
      color: CINEMA_INDICATOR_BACKGROUND_COLOR,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CinemaStatusIndicator(
              inputColor: GREEN_BUTTON_COLOR,
              inputText: CINEMA_CHOOSE_AVAILABLE),
          CinemaStatusIndicator(
              inputColor: CINEMA_FILLING_FAST_COLOR,
              inputText: CINEMA_CHOOSE_FILLING_FAST),
          CinemaStatusIndicator(
              inputColor: CINEMA_ALLMOST_FULL_COLOR,
              inputText: CINEMA_CHOOSE_ALMOST_FULL)
        ],
      ),
    );
  }
}

class CinemaStatusIndicator extends StatelessWidget {
  const CinemaStatusIndicator(
      {required this.inputColor, required this.inputText});

  final Color inputColor;
  final String inputText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 10,
          color: inputColor,
        ),
        SizeBoxR12(),
        Text(
          inputText,
          style: TextStyle(
            color: inputColor,
            fontSize: NORMAL_FONT_SIZE_2X,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        )
      ],
    );
  }
}
