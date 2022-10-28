


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
import 'config_vo_cinema_time_slot_status_vo.dart';

part 'cinema_time_slot_status_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_TIMESLOT_VO,adapterName: "CinemaTimeslotVOAdapter")
class CinemaTimeslotVO{
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name:'title')
  @HiveField(1)
  String? title;

  @JsonKey(name:'color')
  @HiveField(2)
  String? color;


  CinemaTimeslotVO(this.id, this.title, this.color);

  factory CinemaTimeslotVO.fromJson(Map<String,dynamic>json)=>_$CinemaTimeslotVOFromJson(json);

  Map<String,dynamic>toJson()=>_$CinemaTimeslotVOToJson(this);
}
