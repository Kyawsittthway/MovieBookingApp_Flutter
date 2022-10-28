
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'config_vo.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CONFIG_VO,adapterName: "ConfigVOAdapter")
class ConfigVO{

  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name:'key')
  @HiveField(1)
  String? key;

  @JsonKey(name:'value')
  @HiveField(2)
  String? value;

  ConfigVO(this.id, this.key, this.value);

  factory ConfigVO.fromJson(Map<String,dynamic>json)=>_$ConfigVOFromJson(json);

  Map<String,dynamic>toJson()=>_$ConfigVOToJson(this);
  String? getReleaseDay(){
    return value?.substring(8,11);
  }
  String? getReleaseYear(){
    return value?.substring(0,4);
  }
  String? getReleaseMonthInNumber(){
   return  value?.substring(5,7);

  }
  String? getvalue(){
    return "${getReleaseDay()} ${getReleaseMonth()} ${getReleaseYear()} ";
  }
  
  String? MonthInWord(String month){
    Map<String,String> monthConverter = {
      "01":"Jan",
      "02":"Feb",
      "03":"Mar",
      "04":"Apr",
      "05":"May",
      "06":"Jun",
      "07":"Jul",
      "08":"Aug",
      "09":"Sep",
      "10":"Oct",
      "11":"Nov",
      "12":"Dec",
    };
    return monthConverter[month];
  }
  String? getReleaseMonth(){
    Map<String,String> monthConverter = {
      "1":"Jan",
      "2":"Feb",
      "3":"Mar",
      "4":"Apr",
      "5":"May",
      "6":"Jun",
      "7":"Jul",
      "8":"Aug",
      "9":"Sep",
      "10":"Oct",
      "11":"Nov",
      "12":"Dec",
    };
    String month = value?.substring(5,7) ?? "";
    print("Month##############$month");
    return  monthConverter[month];
  }
}