import 'package:json_annotation/json_annotation.dart';

part 'checkout_timeslot_vo.g.dart';

@JsonSerializable()
class CheckoutTimeslotVO{

  @JsonKey(name: 'cinema_day_timeslot_id')
  int? timeslotId;

  @JsonKey(name:'start_time')
  String? startTime;

  CheckoutTimeslotVO(this.timeslotId, this.startTime);

  factory CheckoutTimeslotVO.fromJson(Map<String,dynamic>json)=>_$CheckoutTimeslotVOFromJson(json);

  Map<String,dynamic>toJson()=>_$CheckoutTimeslotVOToJson(this);
}
// "cinema_day_timeslot_id": 25,
// "start_time": "10:00 AM"