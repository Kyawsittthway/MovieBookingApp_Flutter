import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
import 'facilities_vo.dart';

part 'cinema_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_VO,adapterName: "CinemaVOAdapter")
class CinemaVO{

    @JsonKey(name:'id')
    @HiveField(0)
    int? id;

    @JsonKey(name:'name')
    @HiveField(1)
    String? name;

    @JsonKey(name:'phone')
    @HiveField(2)
    String? phone;

    @JsonKey(name:'email')
    @HiveField(3)
    String? email;

    @JsonKey(name:'address')
    @HiveField(4)
    String? address;

    @JsonKey(name:'promo_vdo_url')
    @HiveField(5)
    String? promoVideoURL;

    @JsonKey(name:'facilities')
    @HiveField(6)
    List<FacilitiesVO>? facilities;


    @JsonKey(name:'safety')
    @HiveField(7)
    List<String>? safety;

    CinemaVO(this.id, this.name, this.phone, this.email, this.address,
      this.promoVideoURL, this.facilities, this.safety);

    factory CinemaVO.fromJson(Map<String,dynamic>json)=>_$CinemaVOFromJson(json);

    Map<String,dynamic>toJson()=>_$CinemaVOToJson(this);
}
