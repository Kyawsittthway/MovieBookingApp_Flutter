
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

import '../../data.vos/vos/cinema_by_date_vo.dart';

part 'get_cinema_and_showtime_by_date_response.g.dart';

@JsonSerializable()
class GetCinemaAndShowtimeByDateResponse extends BaseResponseVO{

  @JsonKey(name:'data')
  List<CinemaByDateVO>? data;

  GetCinemaAndShowtimeByDateResponse(this.data,int? code, String? message) : super(code, message);

  factory GetCinemaAndShowtimeByDateResponse.fromJson(Map<String,dynamic>json)=>_$GetCinemaAndShowtimeByDateResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetCinemaAndShowtimeByDateResponseToJson(this);

}