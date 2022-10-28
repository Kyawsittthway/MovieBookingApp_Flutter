import '../currentAppState.dart';
import '../data.vos/models/padc_api_model.dart';
import '../data.vos/models/padc_api_model_impl.dart';
import '../data.vos/vos/cinema_by_date_vo.dart';
import '../data.vos/vos/cinema_vo.dart';
import '../data.vos/vos/config_vo.dart';
import '../data.vos/vos/config_vo_cinema_time_slot_status_vo.dart';

class CinemaDateTimeRepository{
  static final CinemaDateTimeRepository _singleton = CinemaDateTimeRepository._internal();

  factory CinemaDateTimeRepository(){
    return _singleton;
  }
  CinemaDateTimeRepository._internal();

  ConfigVO? cinemaUpdatedTime;
  ConfigVoCinemaTimeSlotStatusVO? timeslotsStatusList;
  List<CinemaVO> cinemaList = [];
  List<CinemaByDateVO> cinemaByDateList = [];
  PadcApiModel padcApiModel = PadcApiModelImpl();


  void setUpCinemaData(){
    padcApiModel.getConfigResponse().then((response){
        cinemaUpdatedTime = ConfigVO.fromJson(response.data['data'][0]);
        timeslotsStatusList = ConfigVoCinemaTimeSlotStatusVO.fromJson(response.data['data'][1]);
        print("Timeslot status list from set state :: $timeslotsStatusList");
    }).catchError((error){print("GET CONFIG ERROR :: ${error}");});

    // padcApiModel.getCinemaAndShowtimeByDate(CurrentAppState.userToken).then((result){
    //     cinemaByDateList = result;
    //     print("GET CINEMA BY TIME  REULST :: ${cinemaByDateList}");
    //
    // }).catchError((error){print("GET CINEMA AND SHOWTIME ERROR :: ${error}");});

    padcApiModel.getCinema().then((cinema){
        cinemaList = cinema;
        print("GET CINEMA RESULT :: ${cinemaList}");
    }).catchError((error){print("GET CINEMA ERROR :: ${error}");});
  }




}