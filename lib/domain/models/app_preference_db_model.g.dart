// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preference_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppPreferenceAdapter extends TypeAdapter<AppPreference> {
  @override
  final int typeId = 3;

  @override
  AppPreference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppPreference(
      id: fields[0] as String?,
      isDark: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AppPreference obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isDark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppPreferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
