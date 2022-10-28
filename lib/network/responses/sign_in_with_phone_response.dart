
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data.vos/vos/user_info_vo.dart';

import '../../persistence/hive_constants.dart';

part 'sign_in_with_phone_response.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SIGN_IN_RESPONSE,adapterName: "SignInResponseAdapter")
class SignInWithPhoneResponse{

  @JsonKey(name: 'code')
  @HiveField(0)
  int? code;

  @JsonKey(name:'message')
  @HiveField(1)
  String? message;

  @JsonKey(name:'data')
  @HiveField(2)
  UserInfoVO? data;

  @JsonKey(name:'token')
  @HiveField(3)
  String? token;

  SignInWithPhoneResponse(this.code, this.message, this.data, this.token);

  factory SignInWithPhoneResponse.fromJson(Map<String,dynamic>json)=>_$SignInWithPhoneResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$SignInWithPhoneResponseToJson(this);
}