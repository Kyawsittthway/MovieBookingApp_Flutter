import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

import '../../data.vos/vos/snack_vo.dart';

part 'get_snack_response.g.dart';

@JsonSerializable()
class GetSnackResponse extends BaseResponseVO{

  @JsonKey(name: 'data')
  List<SnackVO>? snacks;


  GetSnackResponse(this.snacks,int? code, String? message) : super(code, message);

  factory GetSnackResponse.fromJson(Map<String,dynamic>json)=>_$GetSnackResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetSnackResponseToJson(this);

}