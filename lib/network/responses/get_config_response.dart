
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

import '../../data.vos/vos/config_vo.dart';

part 'get_config_response.g.dart';
@JsonSerializable()
class GetConfigResponse extends BaseResponseVO{

  @JsonKey(name: 'data')
  ConfigVO? data;
  GetConfigResponse(this.data,int? code, String? message) : super(code, message);

  factory GetConfigResponse.fromJson(Map<String,dynamic>json)=>_$GetConfigResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetConfigResponseToJson(this);

}