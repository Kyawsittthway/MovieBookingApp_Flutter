
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

import '../../data.vos/vos/checkout_response_vo.dart';

part 'get_checkout_response.g.dart';

@JsonSerializable()
class GetCheckoutResponse extends BaseResponseVO{

  @JsonKey(name:'data')
  CheckoutResponseVO? data;
  GetCheckoutResponse(int? code, String? message,this.data) : super(code, message);
  factory GetCheckoutResponse.fromJson(Map<String,dynamic>json)=>_$GetCheckoutResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetCheckoutResponseToJson(this);


}