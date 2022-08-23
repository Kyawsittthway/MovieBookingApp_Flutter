import 'dart:ffi';

import 'package:dotted_line/dotted_line.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';

import '../common_widgets_view/interfont_text_widget.dart';
import '../resources/dimens.dart';
import '../resources/fonts.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

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
        title: InterFontTextWidget(
          "Checkout",
          fontSize: APPBAR_TITLE_FONT_SIZE,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  ///Movie Title Section
                  Row(
                    children: [
                      InterFontTextWidget("Emily"),
                      SizedBox(
                        width: 3.0,
                      ),
                      InterFontTextWidget("(3D)(U/A)"),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),

                  ///Movie place Section
                  Row(
                    children: [
                      InterFontTextWidget("JCGV : Junction City"),
                      SizedBox(
                        width: 3.0,
                      ),
                      InterFontTextWidget("(SCREEN 2)")
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  ///Date Time Place Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(
                            height: 10.0,
                          ),
                          InterFontTextWidget("Sat, 18 Jun, 2022",
                              fontSize: NORMAL_FONT_SIZE),
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(
                            height: 10.0,
                          ),
                          InterFontTextWidget("Sat, 18 Jun, 2022",
                              fontSize: NORMAL_FONT_SIZE),
                        ],
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Column(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(
                            height: 10.0,
                          ),
                          InterFontTextWidget(
                            "Sat, 18 Jun, 2022",
                            fontSize: NORMAL_FONT_SIZE,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  ///Movie Ticket Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InterFontTextWidget(
                        "M-Ticket(2)",
                        fontSize: SMALL_FONT_SIZE_14,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),

                      ///Ticket Amount Section
                      Container(
                        height: 40.0,
                        child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InterFontTextWidget(
                                    "Gold-G8,G7",
                                  ),
                                  SizedBox(
                                    width: 180.0,
                                  ),
                                  InterFontTextWidget("20000Ks")
                                ],
                              );
                            }),
                      ),
                      Center(
                        child: Container(
                          height: 15.0,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Divider(
                            color: DIVIDER_COLOR1,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ///Food and Beverage Section
                          SectionTitleWidget(sectionTitle:"Food and Beverage",price:"20000Ks",includedIcon: true,),
                          SizedBox(
                            height: 15.0,
                          ),
                          ///Receipt Items from Food and Beverages
                          Container(
                            height: 60.0,
                            child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children:[ Row(
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                              color: GREEN_BUTTON_COLOR,
                                              height: 16.0,
                                              width: 16.0,
                                              child: Center(
                                                  child:Icon(
                                                    Icons.close_sharp,
                                                    size: 15,
                                                  ),),),
                                          onTap: (){

                                          },
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        InterFontTextWidget("Potato Chip(Qt.1)",fontSize:SMALL_FONT_SIZE_14 ,color: DIVIDER_COLOR1,),
                                        SizedBox(width: 100,),
                                        InterFontTextWidget("1000Ks",fontSize:SMALL_FONT_SIZE_14 ,color: DIVIDER_COLOR1,),

                                      ],
                                    ),
                                      SizedBox(height: 15.0,)
                                  ]
                                  );
                                }),
                          ),
                          SizedBox(height: 25.0,),
                          Container(
                            child: DottedLine(
                              dashLength:10.0 ,
                              dashColor: DOTTED_LINE_COLOR1,
                            ),
                          ),
                          SizedBox(height: 25.0,),
                          SectionTitleWidget(sectionTitle:"Convenience Fee",price:"500Ks",includedIcon: false,),
                          SizedBox(height: 25.0,),
                          ///Ticket Policy Section
                          GestureDetector(
                            child: Container(
                              width: 200.0,
                              height: 30.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.info,color: Colors.white,),
                                  SizedBox(width: 5.0,),
                                  InterFontTextWidget("Ticket Cancellion Policy",fontSize: SMALL_FONT_SIZE_14,fontWeight: FontWeight.w500,)
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
                                color: TICKET_POLICY_COLOR,

                              ),
                            ),
                            onTap: (){

                            },
                          ),
                          SizedBox(height: 25.0,),
                          Center(
                            child: Container(
                              height: 15.0,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Divider(
                                color: DIVIDER_COLOR1,
                              ),
                            ),
                          ),
                          SizedBox(height: 25.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InterFontTextWidget(
                                "Total",fontSize: 18.0,color: GREEN_BUTTON_COLOR,
                              ),
                              SizedBox(width: 200.0,),
                              InterFontTextWidget(
                                "22500Ks",fontSize: 18.0,color: GREEN_BUTTON_COLOR,
                              )
                            ],
                          )


                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0,),
            Center(

              child: Container(
                height:50.0,
                width: 240.0,
                child: Center(child: InterFontTextWidget("Continue",color: Colors.black,),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
                  color: GREEN_BUTTON_COLOR
                ),
              ),
            ),
            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }
}

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    required this.sectionTitle,
    required this.price,
    required this.includedIcon,
  });
  final String sectionTitle;
  final String price;
  final bool includedIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(child: Icon(Icons.fastfood),visible: includedIcon,),
        SizedBox(
          width: 5.0,
        ),
        InterFontTextWidget(sectionTitle),
        SizedBox(
          width: 130.0,
        ),
        InterFontTextWidget(price)
      ],
    );
  }
}
