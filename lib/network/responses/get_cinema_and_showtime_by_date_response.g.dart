// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cinema_and_showtime_by_date_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCinemaAndShowtimeByDateResponse _$GetCinemaAndShowtimeByDateResponseFromJson(
        Map<String, dynamic> json) =>
    GetCinemaAndShowtimeByDateResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CinemaByDateVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['code'] as int?,
      json['message'] as String?,
    );

Map<String, dynamic> _$GetCinemaAndShowtimeByDateResponseToJson(
        GetCinemaAndShowtimeByDateResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
