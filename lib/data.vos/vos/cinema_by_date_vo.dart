
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/timeslot_vo.dart';

import '../../persistence/hive_constants.dart';

part 'cinema_by_date_vo.g.dart';


@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_BY_DATE_VO,adapterName: "CinemaByDateVOAdapter")
class CinemaByDateVO extends HiveObject{

  @JsonKey(name:'cinema_id')
  @HiveField(0)
  int? cinemaId;

  @JsonKey(name:'cinema')
  @HiveField(1)
  String? cinemaName;

  @JsonKey(name:'timeslots')
  @HiveField(2)
  List<TimeslotVO>? timeslots;

  CinemaByDateVO(this.cinemaId, this.cinemaName, this.timeslots);

  factory CinemaByDateVO.fromJson(Map<String,dynamic>json)=>_$CinemaByDateVOFromJson(json);

  Map<String,dynamic>toJson()=>_$CinemaByDateVOToJson(this);

}
