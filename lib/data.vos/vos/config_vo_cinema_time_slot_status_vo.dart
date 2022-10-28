import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
import 'cinema_time_slot_status_vo.dart';

part 'config_vo_cinema_time_slot_status_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CONFIG_VO_CINEMA_TIMESLOT_VO,adapterName: "ConfigVOCinemaTimeSlotStatusVOAdapter")
class ConfigVoCinemaTimeSlotStatusVO{

  @JsonKey(name:'id')
  @HiveField(1)
  int? id;

  @JsonKey(name:'key')
  @HiveField(2)
  String? key;

  @JsonKey(name:'value')
  @HiveField(3)
  List<CinemaTimeslotVO>? timeslotStatus;

  ConfigVoCinemaTimeSlotStatusVO(this.id, this.key, this.timeslotStatus);

  factory ConfigVoCinemaTimeSlotStatusVO.fromJson(Map<String,dynamic>json)=>_$ConfigVoCinemaTimeSlotStatusVOFromJson(json);

  Map<String,dynamic>toJson()=>_$ConfigVoCinemaTimeSlotStatusVOToJson(this);
}

// "id": 2,
// "key": "cinema_timeslot_status",
// "value": [