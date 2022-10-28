
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'snack_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACK_VO,adapterName: "SnackVOAdapter")
class SnackVO extends HiveObject{

  @JsonKey(name:'id')
  @HiveField(0)
  int? id;

  @JsonKey(name:'name')
  @HiveField(1)
  String? name;

  @JsonKey(name:'description')
  @HiveField(2)
  String? description;

  @JsonKey(name:'price')
  @HiveField(3)
  int? price;

  @JsonKey(name:'category_id')
  @HiveField(4)
  int? categoryId;

  @JsonKey(name:'image')
  @HiveField(5)
  String? imagePath;

  SnackVO(this.id, this.name, this.description, this.price, this.categoryId,
      this.imagePath);

  factory SnackVO.fromJson(Map<String,dynamic>json)=>_$SnackVOFromJson(json);

  Map<String,dynamic>toJson()=>_$SnackVOToJson(this);
}
// "id": 1,
// "name": "Burger Combo1",
// "description": "Et dolores eaque officia aut.",
// "price": 2,
// "category_id": 1,
// "image": "https://tmba.padc.com.mm/img/snack.jpg"