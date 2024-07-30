// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedListModelAdapter extends TypeAdapter<SavedListModel> {
  @override
  final int typeId = 2;

  @override
  SavedListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedListModel(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      listName: fields[2] as String,
      diaryIdList: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedListModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.listName)
      ..writeByte(3)
      ..write(obj.diaryIdList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
