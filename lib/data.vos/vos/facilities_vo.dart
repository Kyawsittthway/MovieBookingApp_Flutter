import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'facilities_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_FACILITIES_VO,adapterName: "FacilitiesVOAdapter")
class FacilitiesVO{

    @JsonKey(name:'id')
    @HiveField(0)
    int? id;

    @JsonKey(name:'title')
    @HiveField(1)
    String? title;

    @JsonKey(name:'img')
    @HiveField(2)
    String? imagePath;

    FacilitiesVO(this.id, this.title, this.imagePath);
    factory FacilitiesVO.fromJson(Map<String,dynamic>json)=>_$FacilitiesVOFromJson(json);

    Map<String,dynamic>toJson()=>_$FacilitiesVOToJson(this);
}
// "id": 1,
// "title": "Parking",
// "img": "https://storage.googleapis.com/mmds-padc/PADC/tmba/cinema.services/parking.png"