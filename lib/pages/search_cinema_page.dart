import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/cinema_time_slot_view_widget.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';

import '../common_widgets_view/interfont_text_widget.dart';
import '../currentAppState.dart';
import '../data.vos/models/padc_api_model.dart';
import '../data.vos/models/padc_api_model_impl.dart';
import '../data.vos/vos/cinema_by_date_vo.dart';
import '../data.vos/vos/cinema_time_slot_status_vo.dart';
import '../data.vos/vos/cinema_vo.dart';
import '../data.vos/vos/config_vo.dart';
import '../data.vos/vos/config_vo_cinema_time_slot_status_vo.dart';
import '../utils.dart';

class SearchCinemaPage extends StatefulWidget {
  SearchCinemaPage({Key? key}) : super(key: key);
  List<String> facilities = ["Airconditioner", "Couple Seats"];
  List<String> formats = ["2D", "3D", "3D IMAX"];
  String facilitiesDropDownValue = "Airconditioner";
  String formatesDropDownValue = "2D";
  double _value = 0;

  @override
  State<SearchCinemaPage> createState() => _SearchCinemaPageState();
}

class _SearchCinemaPageState extends State<SearchCinemaPage> {
  double _startValue = 3500.0;
  double _endValue = 29500.0;

  double _startDateValue = 8.0;
  double _endDateValue = 12.0;

  ConfigVO? cinemaUpdatedTime;
  var slotStatusHolder;
  ConfigVoCinemaTimeSlotStatusVO? timeslotsStatusList;
  List<CinemaVO> cinemaList = [];
  List<CinemaByDateVO> cinemaByDateList = [];
  PadcApiModel padcApiModel = PadcApiModelImpl();

  //CinemaDateTimeRepository cinemaDateTimeRepository = CinemaDateTimeRepository();
  @override
  void initState() {
    super.initState();

    padcApiModel.getConfigResponse().then((response) {
      setState(() {
        cinemaUpdatedTime = ConfigVO.fromJson(response.data['data'][0]);
        timeslotsStatusList =
            ConfigVoCinemaTimeSlotStatusVO.fromJson(response.data['data'][1]);
        print("Timeslot status list from set state :: $timeslotsStatusList");
        slotStatusHolder =
        timeslotsStatusList?.timeslotStatus as List<CinemaTimeslotVO>;
        for (int i = 0; i < slotStatusHolder.length; i++) {
          Utils.idToStatus[slotStatusHolder[i].id] =
              HexColor(slotStatusHolder[i].color);
        }

        print("SlotStatusHolder::${Utils.idToStatus}");

        print(Utils.idToStatus);
      });
    }).catchError((error) {
      print("GET CONFIG ERROR :: ${error}");
    });

    padcApiModel
        .getCinemaAndShowtimeByDateFromDatabase(CurrentAppState.userToken,"2022-10-2")
        .listen((result) {
      setState(() {
        cinemaByDateList = result ?? [];
        print("GET CINEMA BY TIME  REULST :: ${cinemaByDateList}");
      });
    }).onError((error) {
      print("GET CINEMA AND SHOWTIME ERROR :: ${error}");
    });

    padcApiModel.getCinema().then((cinema) {
      setState(() {
        cinemaList = cinema;
        print("GET CINEMA RESULT :: ${cinemaList}");
      });
    }).catchError((error) {
      print("GET CINEMA ERROR :: ${error}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            size: NORMAL_ICON_SIZE,
          ),
        ),
        title: Container(
          width: 300.0,
          child: TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                hintText: "Search the cinema",
                hintStyle: TextStyle(color: DOTTED_LINE_COLOR1)),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_list_alt,
                color: GREEN_BUTTON_COLOR,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 150,

                    child: DropdownButtonFormField(
                      isDense:  true,
                        itemHeight: 50.0,
                        borderRadius:
                            BorderRadius.circular(BORDER_RADIUS_NORMAL),
                        decoration: InputDecoration(
                            hintText: "Facilities",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    BORDER_RADIUS_NORMAL))),
                        hint: Text(
                          "Facilites",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        value: widget.facilitiesDropDownValue,
                        style: TextStyle(color: Colors.black),
                        items: widget.facilities.map((facility) {
                          return DropdownMenuItem<String>(
                            child: Text(facility),
                            value: facility,
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            widget.facilitiesDropDownValue = newValue!;
                            print(widget.facilitiesDropDownValue);
                          });
                        }),
                  ),
                  SizedBox(width:SMALL_PADDING,),
                  Container(
                    width: 150,
                    child: DropdownButtonFormField(

                        borderRadius:
                        BorderRadius.circular(BORDER_RADIUS_NORMAL),
                        decoration: InputDecoration(
                            hintText: "Format",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    BORDER_RADIUS_NORMAL))),
                        hint: Text(
                          "Format",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        value: widget.formatesDropDownValue,
                        style: TextStyle(color: Colors.black),
                        items: widget.formats.map((format) {
                          return DropdownMenuItem<String>(
                            child: Text(format),
                            value: format,
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            widget.formatesDropDownValue = newValue!;
                            print(widget.formatesDropDownValue);
                          });
                        }),
                  )
                ],
              ),
              SizedBox(
                height: SMALL_PADDING,
              ),
              Align(alignment:Alignment.centerLeft,child: InterFontTextWidget("Price Range",fontWeight: FontWeight.w500,fontSize: SMALL_FONT_SIZE_14,)),
              SizedBox(
                height: SMALL_PADDING,
              ),
              Row(
                mainAxisSize:  MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  InterFontTextWidget("3500",fontWeight: FontWeight.w500,fontSize: SMALL_FONT_SIZE_14,color: Colors.grey,),
                  InterFontTextWidget("29500",fontWeight: FontWeight.w500,fontSize: SMALL_FONT_SIZE_14,color: Colors.grey,),
                ]

              ),

              RangeSlider(
                min: 3500.0,
                max: 29500.0,
                divisions: 10,
                activeColor:GREEN_BUTTON_COLOR,
                labels: RangeLabels(
                  _startValue.round().toString(),
                  _endValue.round().toString(),
                ),
                values: RangeValues(_startValue, _endValue),
                onChanged: (values) {
                  setState(() {
                    _startValue = values.start;
                    _endValue = values.end;
                  });
                },
              ),

              SizedBox(
                height: SMALL_PADDING,
              ),
              Align(alignment:Alignment.centerLeft,child: InterFontTextWidget("Show Time",fontWeight: FontWeight.w500,fontSize: SMALL_FONT_SIZE_14,)),
              SizedBox(
                height: SMALL_PADDING,
              ),
              Row(
                  mainAxisSize:  MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    InterFontTextWidget("8 AM",fontWeight: FontWeight.w500,fontSize: SMALL_FONT_SIZE_14,color: Colors.grey,),
                    InterFontTextWidget("12 PM",fontWeight: FontWeight.w500,fontSize: SMALL_FONT_SIZE_14,color: Colors.grey,),
                  ]

              ),

              RangeSlider(
                min: 8.0,
                max: 12.0,
                divisions: 10,
                activeColor:GREEN_BUTTON_COLOR,
                labels: RangeLabels(
                  _startDateValue.round().toString(),
                  _endDateValue.round().toString(),
                ),
                values: RangeValues(_startDateValue, _endDateValue),
                onChanged: (values) {
                  setState(() {
                    _startDateValue = values.start;
                    _endDateValue = values.end;
                  });
                },
              ),
              SizedBox(
                height: SMALL_PADDING,
              ),
              TimeSlotSection(
                cinemas: cinemaList,
                cinemasByDate: cinemaByDateList,
                timeslotStatus: timeslotsStatusList ??
                    ConfigVoCinemaTimeSlotStatusVO(0, "", []), configVO: cinemaUpdatedTime ?? ConfigVO(0, "", "value"), padcApiModel: padcApiModel, isChooseCinemaTimePage: false,),
            ],
          ),
        ),
      ),   
    );
  }
}
