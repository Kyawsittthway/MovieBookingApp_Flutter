
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'city_vo.g.dart';


@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CITY_VO,adapterName: 'CityVOAdapter')
class CityVO{

    @JsonKey(name: 'id')
    @HiveField(0)
    int? id;

    @JsonKey(name:'name')
    @HiveField(1)
    String? name;

    @JsonKey(name:'created_at')
    @HiveField(2)
    String? createdAt;

    @JsonKey(name:'updated_at')
    @HiveField(3)
    String? updatedAt;

    CityVO(this.id, this.name, this.createdAt, this.updatedAt);

    factory CityVO.fromJson(Map<String,dynamic>json)=>_$CityVOFromJson(json);

    Map<String,dynamic>toJson()=>_$CityVOToJson(this);
}

// "id": 1,
// "name": "Yangon",
// "created_at": "2022-09-16T18:18:29.000000Z",
// "updated_at": "2022-09-16T18:18:29.000000Z"