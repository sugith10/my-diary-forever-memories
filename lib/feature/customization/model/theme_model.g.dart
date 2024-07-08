// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeModelAdapter extends TypeAdapter<ThemeModel> {
  @override
  final int typeId = 6;

  @override
  ThemeModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeModel.day;
      case 1:
        return ThemeModel.night;
      default:
        return ThemeModel.day;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeModel obj) {
    switch (obj) {
      case ThemeModel.day:
        writer.writeByte(0);
        break;
      case ThemeModel.night:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
