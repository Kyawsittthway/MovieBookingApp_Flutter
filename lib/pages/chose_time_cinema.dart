import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_r12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_r6.dart';
import 'package:movie_booking_app/config/config_values.dart';
import 'package:movie_booking_app/currentAppState.dart';
import 'package:movie_booking_app/data.vos/vos/cinema_time_slot_status_vo.dart';
import 'package:movie_booking_app/data.vos/vos/config_vo_cinema_time_slot_status_vo.dart';
import 'package:movie_booking_app/data.vos/vos/timeslot_vo.dart';
import 'package:movie_booking_app/models/movie_info_item.dart';
import 'package:movie_booking_app/network/padc_api.dart';
import 'package:movie_booking_app/pages/food_and_beverage_page.dart';
import 'package:movie_booking_app/persistence/dao/cinema_timeslot_dao.dart';
import 'package:movie_booking_app/persistence/dao/config_dao.dart';
import 'package:movie_booking_app/repository/cinema_data_time_repository.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';

import '../common_widgets_view/cinema_time_slot_view_widget.dart';
import '../config/environment_config.dart';
import '../data.vos/models/padc_api_model.dart';
import '../data.vos/models/padc_api_model_impl.dart';
import '../data.vos/vos/cinema_by_date_vo.dart';
import '../data.vos/vos/cinema_vo.dart';
import '../data.vos/vos/config_vo.dart';
import '../data.vos/vos/facilities_vo.dart';
import '../resources/strings.dart';
import '../utils.dart';

class ChooseTimeCinema extends StatefulWidget {
  @override
  State<ChooseTimeCinema> createState() => _ChooseTimeCinemaState();
  static List<CinemaByDateVO> cinemaByDateList = [];
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

  ConfigVO? cinemaUpdatedTime;
  var slotStatusHolder;
  ConfigVoCinemaTimeSlotStatusVO? timeslotsStatusList;
  List<CinemaVO> cinemaList = [];

  PadcApiModel padcApiModel = PadcApiModelImpl();
  List<int> daysInWeek = [];
  ConfigDao mConfigDao = ConfigDao();
  CinemaTimeslotDao mCinemaTimeslotDao = CinemaTimeslotDao();

  //CinemaDateTimeRepository cinemaDateTimeRepository = CinemaDateTimeRepository();
  @override
  void initState() {
    super.initState();

    ///Config Resposne from network
    padcApiModel.getConfigResponse().then((response) {
      setState(() {
        cinemaUpdatedTime = ConfigVO.fromJson(response.data['data'][0]);
        mConfigDao.saveConfig(cinemaUpdatedTime!);
        timeslotsStatusList =
            ConfigVoCinemaTimeSlotStatusVO.fromJson(response.data['data'][1]);
        print("Timeslot status list from set state :: $timeslotsStatusList");
        slotStatusHolder =
            timeslotsStatusList?.timeslotStatus as List<CinemaTimeslotVO>;
        mCinemaTimeslotDao.saveAllCinemaTimeslots(slotStatusHolder,
            "${cinemaUpdatedTime?.getReleaseYear()}-${cinemaUpdatedTime?.getReleaseMonthInNumber()}-${cinemaUpdatedTime?.getReleaseDay()}");
        for (int i = 0; i < slotStatusHolder.length; i++) {
          Utils.idToStatus[slotStatusHolder[i].id] =
              HexColor(slotStatusHolder[i].color);
        }
        int currentDay = int.parse(cinemaUpdatedTime?.getReleaseDay() ?? "");
        int mutatedMonth =
            int.parse(cinemaUpdatedTime?.getReleaseMonthInNumber() ?? "");
        daysInWeek.add(currentDay);
        for (int i = 0; i < 14; i++) {
          if (currentDay <= 30) {
            currentDay++;
            daysInWeek.add(currentDay);
          } else {
            currentDay = 1;
            if (mutatedMonth > 12) {
              mutatedMonth = 1;
            } else {
              mutatedMonth++;
            }
            daysInWeek.add(currentDay);
          }
        }

        print("SlotStatusHolder::${Utils.idToStatus}");

        print(Utils.idToStatus);

        print("Day in weees ;: ${daysInWeek}");
      });
    }).catchError((error) {
      print("GET CONFIG ERROR :: ${error}");
    });

    ///Configs from database
    padcApiModel
        .getConfigByDateKeyFromDatabase(
            "${cinemaUpdatedTime?.getReleaseYear()}-${cinemaUpdatedTime?.getReleaseMonthInNumber()}-${cinemaUpdatedTime?.getReleaseDay()}")
        .then((configs) {
      setState(() {
        cinemaUpdatedTime = configs;
      });
    }).catchError((error) {
      print("Error fetching config from database :: $error");
    });

    padcApiModel
        .getCinemaTimeslotsByDateKeyFromDatabase(
            "${cinemaUpdatedTime?.getReleaseYear()}-${cinemaUpdatedTime?.getReleaseMonthInNumber()}-${cinemaUpdatedTime?.getReleaseDay()}")
        .then((cinemaTimeslots) {
      setState(() {
        slotStatusHolder = cinemaTimeslots;
      });
    }).catchError((error) {
      print("Error fetching cinema timeslots from database :: $error");
    });

    /// Cinema and Show Time
    // padcApiModel
    //     .getCinemaAndShowtimeByDate("${cinemaUpdatedTime?.getReleaseYear()}-${cinemaUpdatedTime?.getReleaseMonthInNumber()}-${cinemaUpdatedTime?.getReleaseDay()}",CurrentAppState.userToken)
    //     .then((result) {
    //   setState(() {
    //     ChooseTimeCinema.cinemaByDateList = result;
    //     print("GET CINEMA BY TIME  REULST :: ${ChooseTimeCinema.cinemaByDateList}");
    //   });
    // }).catchError((error) {
    //   print("GET CINEMA AND SHOWTIME ERROR :: ${error}");
    // });

    ///Cinema and Show Time from Database

    padcApiModel
        .getCinemaAndShowtimeByDateFromDatabase(
            "${cinemaUpdatedTime?.getReleaseYear()}-${cinemaUpdatedTime?.getReleaseMonthInNumber()}-${cinemaUpdatedTime?.getReleaseDay()}",
            CurrentAppState.userToken)
        .listen((cinemaTimeslots) {
      setState(() {
        ChooseTimeCinema.cinemaByDateList = cinemaTimeslots ?? [];
      });
    }).onError((error) {
      print("Error Fetching cinema and showtime ");
    });

    /// Get Cinema
    padcApiModel.getCinema().then((cinema) {
      setState(() {
        cinemaList = cinema;
        print("GET CINEMA RESULT :: ${cinemaList}");
      });
    }).catchError((error) {
      print("GET CINEMA ERROR :: ${error}");
    });

    /// Get Cinema From database
    padcApiModel.getCinemasFromDatabase().then((cinema) {
      setState(() {
        cinemaList = cinema;
      });
    }).catchError((error) {
      print("Error fetching cinema from database :: $error}");
    });
  }

  @override
  Widget build(BuildContext context) {
    var rootContext = this.context;
    print("widget rebuild");
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: MEDIUM_ICON_SIZE,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Icon(CupertinoIcons.paperplane),
          Padding(
            padding: EdgeInsets.only(top: SMALL_PADDING_15),
            child: InterFontTextWidget("${CurrentAppState.currentCityname}",
                fontStyle: FontStyle.italic),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              DayView(
                configs: cinemaUpdatedTime,
                daysInWeek: daysInWeek,
                padcApiModel: padcApiModel,
                cinemasByDates: ChooseTimeCinema.cinemaByDateList,
                root: rootContext,
              ),
              FormatChipView(format: format),
              IndicatorViews(
                  timeslotsStatus: timeslotsStatusList?.timeslotStatus ?? []),
              SizedBox(
                height: MEDIUM_HEIGHT,
              ),
              TimeSlotSection(
                cinemas: cinemaList,
                cinemasByDate: ChooseTimeCinema.cinemaByDateList,
                timeslotStatus: timeslotsStatusList ??
                    ConfigVoCinemaTimeSlotStatusVO(0, "", []),
                configVO: cinemaUpdatedTime ?? ConfigVO(0, "", "value"),
                padcApiModel: padcApiModel,
                isChooseCinemaTimePage: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseTimeCinemaDialogBox extends StatelessWidget {
  ChooseTimeCinemaDialogBox(
      {required this.cinemaName,
      required this.cinemaVO,
      required this.timeslotVO,
      required this.config,
      required this.padcApiModel});

  final String cinemaName;
  final CinemaVO cinemaVO;
  final TimeslotVO timeslotVO;
  final ConfigVO config;
  final PadcApiModel padcApiModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.symmetric(
          horizontal: SMALL_PADDING, vertical: SMALL_PADDING),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
          color: Colors.black),
      child: Column(
        children: [
          InterFontTextWidget(CINEMA_CHOOSE_TNC),
          SizeBoxH12(),
          InterFontTextWidget(
            TC,
            fontWeight: FontWeight.w400,
            fontSize: NORMAL_FONT_SIZE,
          ),
          SizeBoxH12(),
          Container(
            height: CHOOSE_TIME_CINEMA_POP_UP_IMAGE_VIEW_HEIGHT,
            width: KILO_WIDTH,
            child: Image.asset("assets/icons/term_condition_icon.png"),
          ),
          SizeBoxH12(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text(
                  CINEMA_CHOOSE_POP_UP_CANCEL_TEXT,
                  style: TextStyle(color: GREEN_BUTTON_COLOR),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    side: BorderSide(
                      color: GREEN_BUTTON_COLOR,
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  CurrentAppState.receipt.cinemaName = cinemaName;
                  CurrentAppState.receipt.location = cinemaVO.address;
                  CurrentAppState.receipt.time = timeslotVO.startTime;
                  CurrentAppState.cinemaDayTimeslotId = timeslotVO.id ?? 0;
                  CurrentAppState.receipt.date =
                      " ${config.getReleaseDay()} ${config.getReleaseMonth()} ${config.getReleaseYear()}";
                  goToFoodAndBeverage(context);
                },
                child: Text(CINEMA_CHOOSE_POP_UP_ACCEPT_TEXT,
                    style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(primary: GREEN_BUTTON_COLOR),
              )
            ],
          )
        ],
      ),
    );
  }

  void goToFoodAndBeverage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FoodAndBeveragePage()),
    );
  }
}

class FormatChipView extends StatelessWidget {
  const FormatChipView({
    required this.format,
  });

  final List<String> format;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: SMALL_PADDING),
      margin: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
      height: XL_HEIGHT,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: format.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(right: SMALL_PADDING_15),
              height: X_HEIGHT,
              width: (format[index] == "3D DEBOX") ? KILO_HEIGHT : XXXXL_HEIGHT,
              decoration: BoxDecoration(
                  color: CINEMA_FORMAT_CHIP_COLOR,
                  border: Border.all(
                      color: Colors.white, width: MEDIUM_BORDER_WIDTH),
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL)),
              child: Center(child: InterFontTextWidget("${format[index]}")),
            );
          }),
    );
  }
}

class DayView extends StatefulWidget {
  final ConfigVO? configs;
  final List<int> daysInWeek;
  List<CinemaByDateVO> cinemasByDates;
  PadcApiModel padcApiModel;
  BuildContext root;

  DayView(
      {required this.configs,
      required this.daysInWeek,
      required this.padcApiModel,
      required this.cinemasByDates,
      required this.root});

  @override
  State<DayView> createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  bool isChosen = false;
  int selectedIndex = 0;

  bool isSelectedView(int index1, int index2) {
    // print("Index 1 :: $index1 , Index 2 :: $index2");
    if (index1 == index2) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: SMALL_PADDING),
      margin: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
      height: KILO_HEIGHT_1P5,
      child: ListView.builder(
          itemCount: widget.daysInWeek.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(SMALL_PADDING),
                    height: KILO_HEIGHT_1P5,
                    width: KILO_WIDTH,
                    decoration: BoxDecoration(
                        // color: isSelectedView(index, selectedIndex) == true ? GREEN_BUTTON_COLOR : MOVIE_VIEW_DOT_COLOR,
                        color: ACTOR_LIST_STYLES[EnvironmentConfig.CONFIG_ACTOR_LIST_STYLE] == ActorListStyle.ScrollActorList ?isSelectedView(index, selectedIndex) == true ? GREEN_BUTTON_COLOR : MOVIE_VIEW_DOT_COLOR:MOVIE_VIEW_DOT_COLOR ,
                        border: ACTOR_LIST_STYLES[EnvironmentConfig.CONFIG_ACTOR_LIST_STYLE] == ActorListStyle.WrapActorList ? Border.all(
                            color: isSelectedView(index, selectedIndex) == true
                                ? GREEN_BUTTON_COLOR
                                : MOVIE_VIEW_DOT_COLOR,
                        width: 5.0): null,
                        borderRadius:
                            BorderRadius.circular(BORDER_RADIUS_NORMAL),
                        boxShadow: [
                          BoxShadow(
                            color: GREEN_BUTTON_COLOR,
                            blurRadius: SMALL_BLUR_RADIUS,
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DayViewTopTicketHoleView(),
                        Container(
                            height: 100,
                            child: DayDetailViewWidget(
                              dateDetails: widget.configs,
                              index: index,
                              daysInWeek: widget.daysInWeek,
                            ))
                      ],
                    ),
                  ),
                  //Right circle cut
                  DayViewTicketRightCircleCut(),
                  //left circle cut
                  DayViewTicketLeftCircleCut(),
                ],
              ),
              onTap: () {
                print(widget.daysInWeek[index]);
                setState(() {
                  // selectedIndex = widget.daysInWeek[index];
                  selectedIndex = index;
                  CurrentAppState.selectedDateForTimeSlot =
                      "${widget.configs?.getReleaseYear()}-${widget.configs?.getReleaseMonthInNumber()}-${widget.daysInWeek[index]}";
                  widget.padcApiModel = PadcApiModelImpl();
                  widget.padcApiModel
                      .getCinemaAndShowtimeByDateFromDatabase(
                    CurrentAppState.selectedDateForTimeSlot,
                    CurrentAppState.userToken,
                  )
                      .listen((result) {
                    (widget.root as Element).reassemble();
                    widget.cinemasByDates = result ?? [];
                    setState(() {
                      ChooseTimeCinema.cinemaByDateList = result ?? [];
                      print(
                          "Dayview cinemaByDate :: ${ChooseTimeCinema.cinemaByDateList}");
                    });
                  }).onError((error) {
                    print("Error from selecting and combinging :: $error");
                  });
                  print(
                      "Current App State(Selected Date for Time Slot :: ${CurrentAppState.selectedDateForTimeSlot})");
                });
              },
            );
          }),
    );
  }
}

class DayViewTicketLeftCircleCut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: CHOOSE_TIME_CINEMA_DAY_VIEW_CIRCLE_CUT_HORIZONTAL,
      bottom: CHOOSE_TIME_CINEMA_DAY_VIEW_CIRCLE_CUT_BOTTOM,
      child: SizedBox(
        height: CIRCLE_CUT_HEIGHT,
        width: XL_WIDTH,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: PRIMARY_BACKGROUND_COLOR,
          ),
        ),
      ),
    );
  }
}

class DayViewTicketRightCircleCut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: CHOOSE_TIME_CINEMA_DAY_VIEW_CIRCLE_CUT_HORIZONTAL,
      bottom: CHOOSE_TIME_CINEMA_DAY_VIEW_CIRCLE_CUT_BOTTOM,
      child: SizedBox(
        height: CIRCLE_CUT_HEIGHT,
        width: XL_WIDTH,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: PRIMARY_BACKGROUND_COLOR,
          ),
        ),
      ),
    );
  }
}

class DayDetailViewWidget extends StatelessWidget {
  ConfigVO? dateDetails;
  int index;
  int currentMonth = 0;
  int mutatedMonth = 0;
  List<int> daysInWeek;

  DayDetailViewWidget(
      {required this.dateDetails,
      required this.index,
      required this.daysInWeek});

  @override
  Widget build(BuildContext context) {
    currentMonth = int.parse(dateDetails?.value?.substring(5, 7) ?? "");
    mutatedMonth = currentMonth;
    List<int> weeks = daysInWeek;
    return Column(
        children: (currentMonth != null && weeks != null)
            ? [
                Visibility(
                  visible: index == 0 ? true : false,
                  child: InterFontTextWidget(
                    "Today",
                    color: Colors.black,
                    fontSize: LARGE_FONT_SIZE,
                  ),
                ),
                InterFontTextWidget(
                  // dateDetails?.MonthInWord("$currentMonth") ?? "",
                  index == 0
                      ? dateDetails?.MonthInWord("$currentMonth") ?? ""
                      : dateDetails?.MonthInWord("$mutatedMonth") ?? "",
                  color: Colors.black,
                  fontSize: LARGE_FONT_SIZE,
                ),
                InterFontTextWidget(
                  weeks[index].toString(),
                  color: Colors.black,
                  fontSize: APPBAR_TITLE_FONT_SIZE,
                ),
              ]
            : [
                Center(
                  child: CircularProgressIndicator(),
                )
              ]);
  }
}

class DayViewTopTicketHoleView extends StatelessWidget {
  const DayViewTopTicketHoleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CHOOSE_TIME_CINEMA_DAY_VIEW_TOP_CONTAINER_HEIGHT,
      width: CHOOSE_TIME_CINEMA_DAY_VIEW_TOP_CONTAINER_WIDTH,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS_CIRCLE),
        color: PRIMARY_BACKGROUND_COLOR,
      ),
    );
  }
}
