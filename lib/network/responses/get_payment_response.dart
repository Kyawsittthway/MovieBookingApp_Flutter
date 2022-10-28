

import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/base_response_vo.dart';

import '../../data.vos/vos/payment_vo.dart';

part 'get_payment_response.g.dart';

@JsonSerializable()
class GetPaymentResponse extends BaseResponseVO{

  @JsonKey(name:'data')
  List<PaymentVO>? data;


  GetPaymentResponse(this.data,int? code, String? message) : super(code, message);

  factory GetPaymentResponse.fromJson(Map<String,dynamic>json)=>_$GetPaymentResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetPaymentResponseToJson(this);

}