// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_vo_cinema_time_slot_status_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfigVOCinemaTimeSlotStatusVOAdapter
    extends TypeAdapter<ConfigVoCinemaTimeSlotStatusVO> {
  @override
  final int typeId = 22;

  @override
  ConfigVoCinemaTimeSlotStatusVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfigVoCinemaTimeSlotStatusVO(
      fields[1] as int?,
      fields[2] as String?,
      (fields[3] as List?)?.cast<CinemaTimeslotVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, ConfigVoCinemaTimeSlotStatusVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.timeslotStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigVOCinemaTimeSlotStatusVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigVoCinemaTimeSlotStatusVO _$ConfigVoCinemaTimeSlotStatusVOFromJson(
        Map<String, dynamic> json) =>
    ConfigVoCinemaTimeSlotStatusVO(
      json['id'] as int?,
      json['key'] as String?,
      (json['value'] as List<dynamic>?)
          ?.map((e) => CinemaTimeslotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConfigVoCinemaTimeSlotStatusVOToJson(
        ConfigVoCinemaTimeSlotStatusVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.timeslotStatus,
    };
