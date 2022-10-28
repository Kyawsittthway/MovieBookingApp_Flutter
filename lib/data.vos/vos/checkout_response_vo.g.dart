// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutResponseVO _$CheckoutResponseVOFromJson(Map<String, dynamic> json) =>
    CheckoutResponseVO(
      json['id'] as int?,
      json['booking_no'] as String?,
      json['booking_date'] as String?,
      json['row'] as String?,
      json['seat'] as String?,
      json['total_seat'] as int?,
      json['total'] as String?,
      json['movie_id'] as int?,
      json['cinema_id'] as int?,
      json['username'] as String?,
      json['timeslot'] == null
          ? null
          : CheckoutTimeslotVO.fromJson(
              json['timeslot'] as Map<String, dynamic>),
      (json['snacks'] as List<dynamic>?)
          ?.map((e) =>
              CheckoutResponseSnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['qr_code'] as String?,
    );

Map<String, dynamic> _$CheckoutResponseVOToJson(CheckoutResponseVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_no': instance.bookingNo,
      'booking_date': instance.bookingDate,
      'row': instance.row,
      'seat': instance.seat,
      'total_seat': instance.totalSeat,
      'total': instance.total,
      'movie_id': instance.movieId,
      'cinema_id': instance.cinemaId,
      'username': instance.userName,
      'timeslot': instance.timeslot,
      'snacks': instance.snacks,
      'qr_code': instance.qrCode,
    };