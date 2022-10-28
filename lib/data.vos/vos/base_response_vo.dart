import 'package:json_annotation/json_annotation.dart';

part 'base_response_vo.g.dart';

@JsonSerializable()
class BaseResponseVO{

  @JsonKey(name:'code')
  int? code;

  @JsonKey(name:'message')
  String? message;

  BaseResponseVO(this.code, this.message);

  factory BaseResponseVO.fromJson(Map<String,dynamic>json)=>_$BaseResponseVOFromJson(json);

  Map<String,dynamic>toJson()=>_$BaseResponseVOToJson(this);
}