
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';


part 'timeslot_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_TIMESLOT_VO,adapterName: "TimeslotVOAdapter")
class TimeslotVO{

  @JsonKey(name:'cinema_day_timeslot_id')
  @HiveField(0)
  int? id;

  @JsonKey(name:'start_time')
  @HiveField(1)
  String? startTime;

  @JsonKey(name: 'status')
  @HiveField(2)
  int? status;

  TimeslotVO(this.id, this.startTime, this.status);
  factory TimeslotVO.fromJson(Map<String,dynamic>json)=>_$TimeslotVOFromJson(json);

  Map<String,dynamic>toJson()=>_$TimeslotVOToJson(this);
}

// "cinema_day_timeslot_id": 7,
// "start_time": "9:30 AM",
// "status": 1