// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_by_date_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaByDateVOAdapter extends TypeAdapter<CinemaByDateVO> {
  @override
  final int typeId = 15;

  @override
  CinemaByDateVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaByDateVO(
      fields[0] as int?,
      fields[1] as String?,
      (fields[2] as List?)?.cast<TimeslotVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaByDateVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cinemaId)
      ..writeByte(1)
      ..write(obj.cinemaName)
      ..writeByte(2)
      ..write(obj.timeslots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaByDateVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaByDateVO _$CinemaByDateVOFromJson(Map<String, dynamic> json) =>
    CinemaByDateVO(
      json['cinema_id'] as int?,
      json['cinema'] as String?,
      (json['timeslots'] as List<dynamic>?)
          ?.map((e) => TimeslotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemaByDateVOToJson(CinemaByDateVO instance) =>
    <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinemaName,
      'timeslots': instance.timeslots,
    };
