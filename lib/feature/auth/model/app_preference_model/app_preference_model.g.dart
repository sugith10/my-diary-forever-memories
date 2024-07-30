// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preference_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppPreferenceModelAdapter extends TypeAdapter<AppPreferenceModel> {
  @override
  final int typeId = 3;

  @override
  AppPreferenceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppPreferenceModel(
      showwelcome: fields[1] as bool?,
      isDark: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AppPreferenceModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.showwelcome)
      ..writeByte(2)
      ..write(obj.isDark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppPreferenceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
