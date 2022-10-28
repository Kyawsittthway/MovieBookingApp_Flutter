import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

import '../../data.vos/vos/seat_vo.dart';


part 'get_seating_plan_response.g.dart';

@JsonSerializable()
class GetSeatingPlanResponse extends BaseResponseVO{

  @JsonKey(name:'data')
  List<SeatVO>? data;
  GetSeatingPlanResponse(int? code, String? message) : super(code, message);

  factory GetSeatingPlanResponse.fromJson(Map<String,dynamic>json)=>_$GetSeatingPlanResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetSeatingPlanResponseToJson(this);

}