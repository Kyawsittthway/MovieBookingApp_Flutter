// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutVO _$CheckoutVOFromJson(Map<String, dynamic> json) => CheckoutVO(
      json['cinema_day_timeslot_id'] as int?,
      json['seat_number'] as String?,
      json['booking_date'] as String?,
      json['movie_id'] as int?,
      json['payment_type_id'] as int?,
      (json['snacks'] as List<dynamic>?)
          ?.map((e) => CheckOutSnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckoutVOToJson(CheckoutVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeslotId,
      'seat_number': instance.seatNumber,
      'booking_date': instance.bookingDate,
      'movie_id': instance.movieId,
      'payment_type_id': instance.paymentTypeId,
      'snacks': instance.snacks,
    };
