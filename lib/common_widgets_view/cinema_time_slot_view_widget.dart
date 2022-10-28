import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_h30.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_r12.dart';
import 'package:movie_booking_app/common_widgets_view/size_box_r6.dart';

import '../data.vos/models/padc_api_model.dart';
import '../data.vos/vos/cinema_by_date_vo.dart';
import '../data.vos/vos/cinema_time_slot_status_vo.dart';
import '../data.vos/vos/cinema_vo.dart';
import '../data.vos/vos/config_vo.dart';
import '../data.vos/vos/config_vo_cinema_time_slot_status_vo.dart';
import '../data.vos/vos/facilities_vo.dart';
import '../data.vos/vos/timeslot_vo.dart';
import '../pages/chose_time_cinema.dart';
import '../pages/cinema_detail_page.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/fonts.dart';
import '../resources/strings.dart';
import '../utils.dart';
import 'interfont_text_widget.dart';

class TimeSlotSection extends StatefulWidget {
  TimeSlotSection(
      {required this.cinemas,
        required this.cinemasByDate,
        required this.timeslotStatus,
        required this.configVO,
        required this.padcApiModel
      });

  final List<CinemaVO> cinemas;
   List<CinemaByDateVO> cinemasByDate;
  final ConfigVoCinemaTimeSlotStatusVO timeslotStatus;
  final ConfigVO configVO;
  final PadcApiModel padcApiModel;

  @override
  State<TimeSlotSection> createState() => _TimeSlotSectionState();
}

class _TimeSlotSectionState extends State<TimeSlotSection> {
  @override
  void initState(){
    setState(() {
      widget.cinemasByDate = ChooseTimeCinema.cinemaByDateList;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SMALL_PADDING_15),
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: ChooseTimeCinema.cinemaByDateList.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpandablePanel(
              header: Container(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.5),
                    )),
                child: CinemaFeaturesVisibleView(
                    cinemas: widget.cinemas,
                    cinemasByDate: ChooseTimeCinema.cinemaByDateList,
                    index: index),
              ),
              collapsed: Container(
                height: 0,
              ),
              expanded: ExpandedTimeSlotViewWidget(
                  timeslots: ChooseTimeCinema.cinemaByDateList[index].timeslots ?? [],
                  slotConfig: widget.timeslotStatus,
                  cinemaName: ChooseTimeCinema.cinemaByDateList[index].cinemaName ?? "",
                  cinemaInfo: widget.cinemas[index],
                  cinemaUpdatedTime: widget.configVO,
                  padcApiModel: widget.padcApiModel,
              ),
              theme: ExpandableThemeData(
                tapHeaderToExpand: true,
                tapBodyToExpand: true,
                hasIcon: false,
              ),
            );
          }),
    );
  }
}

class ExpandedTimeSlotViewWidget extends StatefulWidget {
  final List<TimeslotVO> timeslots;
  final ConfigVoCinemaTimeSlotStatusVO slotConfig;
  final String cinemaName;
  final CinemaVO cinemaInfo;
  final ConfigVO cinemaUpdatedTime;
  final PadcApiModel padcApiModel;
  ExpandedTimeSlotViewWidget(
      {required this.timeslots, required this.slotConfig,required this.cinemaName,required this.cinemaInfo, required this.cinemaUpdatedTime, required this.padcApiModel});

  @override
  State<ExpandedTimeSlotViewWidget> createState() => _ExpandedTimeSlotViewWidgetState();
}

class _ExpandedTimeSlotViewWidgetState extends State<ExpandedTimeSlotViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: widget.timeslots.length<3 == true ? CHOOSE_TIME_CINEMA_DAY_VIEW_EXPANDED_SECTION_HEIGHT *(widget.timeslots.length / 3) :CHOOSE_TIME_CINEMA_DAY_VIEW_EXPANDED_SECTION_HEIGHT *
            (widget.timeslots.length / 6),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: widget.timeslots.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {

                  showDialog(
                      context: context,
                      builder: (context) => Center(
                        child: ChooseTimeCinemaDialogBox(cinemaName: widget.cinemaName, cinemaVO: widget.cinemaInfo, config: widget.cinemaUpdatedTime, timeslotVO: widget.timeslots[index], padcApiModel: widget.padcApiModel,),
                      ));
                },
                child: Container(
                  margin: EdgeInsets.all(SMALL_PADDING),
                  padding: EdgeInsets.all(MICRO_PADDING),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: (Utils.idToStatus[widget.timeslots[index].status] ??
                              Colors.grey),
                          width: MEDIUM_BORDER_WIDTH)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InterFontTextWidget(
                        widget.timeslots[index].startTime ?? "",
                        fontSize: SMALL_FONT_SIZE_14,
                        fontWeight: FontWeight.w600,
                      ),
                      InterFontTextWidget(
                        "3D IMAX",
                        fontSize: NORMAL_FONT_SIZE,
                        fontWeight: FontWeight.w600,
                      ),
                      InterFontTextWidget(
                        "Screen 2",
                        fontSize: NORMAL_FONT_SIZE,
                        fontWeight: FontWeight.w600,
                      ),
                      // InterFontTextWidget(
                      //   "20 Available",
                      //   fontSize: NORMAL_FONT_SIZE,
                      //   fontWeight: FontWeight.w600,
                      // ),
                    ],
                  ),
                ),
              );
            }),
      ),
      GestureDetector(
        child: Container(
          margin: EdgeInsets.only(bottom: SMALL_PADDING),
          child: Row(
            children: [
              Icon(
                Icons.info,
                color: CINEMA_FEATURES_COLOR,
                size: SMALL_ICON_SIZE,
              ),
              SizeBoxR6(),
              Text(
                CINEMA_CHOOSE_INFO_TEXT_FOR_LONG_PRESS,
                style: TextStyle(
                  color: CINEMA_FEATURES_COLOR,
                  fontSize: SMALL_FONT_SIZE_14,
                ),
              )
            ],
          ),
        ),
        onLongPress: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CinemaDetailPage(cinemaDetails: widget.cinemaInfo,)),
          );
        },
      )
    ]);
  }
}
class CinemaFeaturesVisibleView extends StatefulWidget {
  CinemaFeaturesVisibleView({
    required this.cinemas,
    required this.index,
    required this.cinemasByDate,
  });

  final List<CinemaVO> cinemas;
  final List<CinemaByDateVO> cinemasByDate;
  final int index;

  @override
  State<CinemaFeaturesVisibleView> createState() => _CinemaFeaturesVisibleViewState();
}

class _CinemaFeaturesVisibleViewState extends State<CinemaFeaturesVisibleView> {
  @override
  Widget build(BuildContext context) {
    List<FacilitiesVO>? currentFaciliteis =
    getCurrentFacilites(ChooseTimeCinema.cinemaByDateList[widget.index].cinemaId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InterFontTextWidget(
              "${ChooseTimeCinema.cinemaByDateList[widget.index].cinemaName}",
              fontSize: NORMAL_FONT_SIZE_2X,
              fontWeight: FontWeight.w600,
            ),
            GestureDetector(
              child: Text(
                CINEMA_CHOOSE_CINEMA_SEE_DETAIL,
                style: TextStyle(
                  color: GREEN_BUTTON_COLOR,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CinemaDetailPage(cinemaDetails: widget.cinemas[widget.index])),
                );

              }
            )
          ],
        ),
        SizeBoxH30(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                  itemCount: currentFaciliteis?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        CinemaFeatureView(
                          imagePath: currentFaciliteis != null
                              ? currentFaciliteis[index].imagePath!
                              : "",
                          inputName: currentFaciliteis != null
                              ? currentFaciliteis[index].title!
                              : "",
                        ),
                        SizeBoxR6(),
                      ],
                    );
                  }),
            ),
          ],
        ),
        Divider(
          color: DIVIDER_COLOR,
        ),
        SizeBoxH12(),
      ],
    );
  }

  List<FacilitiesVO>? getCurrentFacilites(int? cinemaId) {
    for (int i = 0; i < widget.cinemas.length; i++) {
      if (widget.cinemas[i].id == cinemaId) {
        return widget.cinemas[i].facilities;
      }
    }
  }
}

class CinemaFeatureView extends StatefulWidget {
  CinemaFeatureView({required this.inputName, required this.imagePath});

  final String inputName;
  final String imagePath;

  @override
  State<CinemaFeatureView> createState() => _CinemaFeatureViewState();
}

class _CinemaFeatureViewState extends State<CinemaFeatureView> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        height: 20,
        width: 20,
        child: Image.network(widget.imagePath),
      ),
      SizeBoxR6(),
      Text(
        widget.inputName,
        style: TextStyle(
          color: CINEMA_FEATURES_COLOR,
          fontFamily: INTER_FONT_FAMILY,
          fontSize: 10,
        ),
      )
    ]);
  }
}

class IndicatorViews extends StatefulWidget {
  final List<CinemaTimeslotVO> timeslotsStatus;

  IndicatorViews({required this.timeslotsStatus});

  @override
  State<IndicatorViews> createState() => _IndicatorViewsState();
}

class _IndicatorViewsState extends State<IndicatorViews> {
  @override
  Widget build(BuildContext context) {
    // print("Timeslots status form  IndicatorView :: ${timeslotsStatus}");
    return Container(
        height: XXL_HEIGHT,
        margin: EdgeInsets.only(top: SMALL_PADDING),
        color: CINEMA_INDICATOR_BACKGROUND_COLOR,
        child: ListView.builder(
            itemCount: widget.timeslotsStatus.length,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: SMALL_PADDING),
                  child: CinemaStatusIndicator(
                      inputColor: HexColor(widget.timeslotsStatus[index].color ?? ""),
                      inputText: widget.timeslotsStatus[index].title ?? ""));
            }));
  }
}

class CinemaStatusIndicator extends StatefulWidget {
  CinemaStatusIndicator({required this.inputColor, required this.inputText});

  final Color inputColor;
  final String inputText;

  @override
  State<CinemaStatusIndicator> createState() => _CinemaStatusIndicatorState();
}

class _CinemaStatusIndicatorState extends State<CinemaStatusIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: MICRO_ICON_SIZE,
          color: widget.inputColor,
        ),
        SizeBoxR12(),
        Text(
          widget.inputText,
          style: TextStyle(
            color: widget.inputColor,
            fontSize: NORMAL_FONT_SIZE_2X,
            fontWeight: FontWeight.w500,
            fontFamily: INTER_FONT_FAMILY,
          ),
        )
      ],
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}