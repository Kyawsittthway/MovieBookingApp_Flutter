import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

part 'get_banners_response.g.dart';

@JsonSerializable()
class GetBannersResponse extends BaseResponseVO{

  @JsonKey(name:'data')
  List<BannerImageVO>? data;

  GetBannersResponse(int code,String message,this.data):super(code,message);
  factory GetBannersResponse.fromJson(Map<String,dynamic>json)=>_$GetBannersResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetBannersResponseToJson(this);
}