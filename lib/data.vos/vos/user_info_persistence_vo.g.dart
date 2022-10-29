// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_persistence_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoPersistenceVOAdapter extends TypeAdapter<UserInfoPersistenceVO> {
  @override
  final int typeId = 24;

  @override
  UserInfoPersistenceVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfoPersistenceVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as UserInfoVO?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfoPersistenceVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.userInfoVO);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoPersistenceVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
