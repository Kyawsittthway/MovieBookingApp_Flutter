// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_timeslot_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutTimeslotVO _$CheckoutTimeslotVOFromJson(Map<String, dynamic> json) =>
    CheckoutTimeslotVO(
      json['cinema_day_timeslot_id'] as int?,
      json['start_time'] as String?,
    );

Map<String, dynamic> _$CheckoutTimeslotVOToJson(CheckoutTimeslotVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.timeslotId,
      'start_time': instance.startTime,
    };
