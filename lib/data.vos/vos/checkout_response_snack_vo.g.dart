// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_response_snack_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutResponseSnackVO _$CheckoutResponseSnackVOFromJson(
        Map<String, dynamic> json) =>
    CheckoutResponseSnackVO(
      json['id'] as int?,
      json['name'] as String?,
      json['description'] as String?,
      json['image'] as String?,
      json['price'] as int?,
      json['unit_price'] as int?,
      json['quantity'] as int?,
      json['total_price'] as int?,
    );

Map<String, dynamic> _$CheckoutResponseSnackVOToJson(
        CheckoutResponseSnackVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.imagePath,
      'price': instance.price,
      'unit_price': instance.unit_price,
      'quantity': instance.quantity,
      'total_price': instance.totalPrice,
    };
