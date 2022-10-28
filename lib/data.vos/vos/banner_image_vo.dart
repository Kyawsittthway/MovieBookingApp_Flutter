import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'banner_image_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BANNER_IMAGE_VO,adapterName:"BannerImageVOAdapter")
class BannerImageVO{

  @JsonKey(name:'id')
  @HiveField(0)
  int? id;

  @JsonKey(name:'title')
  @HiveField(1)
  String? title;

  @JsonKey(name:'url')
  @HiveField(2)
  String? imageURL;

  @JsonKey(name:'is_active')
  @HiveField(3)
  int? isActive;

  @JsonKey(name:'created_at')
  @HiveField(4)
  String? createdAt;

  @JsonKey(name:'updated_at')
  @HiveField(5)
  String? updatedAt;

  BannerImageVO(this.id, this.title, this.imageURL, this.isActive,
      this.createdAt, this.updatedAt);
  factory BannerImageVO.fromJson(Map<String,dynamic>json)=>_$BannerImageVOFromJson(json);

  Map<String,dynamic>toJson()=>_$BannerImageVOToJson(this);


}