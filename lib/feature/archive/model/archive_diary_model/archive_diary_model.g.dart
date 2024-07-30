// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_diary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArchiveDiaryModelAdapter extends TypeAdapter<ArchiveDiaryModel> {
  @override
  final int typeId = 5;

  @override
  ArchiveDiaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArchiveDiaryModel(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      title: fields[2] as String,
      content: fields[3] as String,
      imagePath: fields[4] as String?,
      imagePathTwo: fields[5] as String?,
      imagePathThree: fields[6] as String?,
      imagePathFour: fields[7] as String?,
      imagePathFive: fields[8] as String?,
      background: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArchiveDiaryModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.imagePathTwo)
      ..writeByte(6)
      ..write(obj.imagePathThree)
      ..writeByte(7)
      ..write(obj.imagePathFour)
      ..writeByte(8)
      ..write(obj.imagePathFive)
      ..writeByte(9)
      ..write(obj.background);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArchiveDiaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
