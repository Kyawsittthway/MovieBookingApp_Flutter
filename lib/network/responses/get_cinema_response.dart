
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

import '../../data.vos/vos/cinema_vo.dart';

part 'get_cinema_response.g.dart';

@JsonSerializable()
class GetCinemaResponse extends BaseResponseVO{

  @JsonKey(name:'data')
  List<CinemaVO>? data;

  GetCinemaResponse(this.data,int? code, String? message) : super(code, message);

  factory GetCinemaResponse.fromJson(Map<String,dynamic>json)=>_$GetCinemaResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetCinemaResponseToJson(this);

}