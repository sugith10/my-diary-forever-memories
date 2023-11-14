// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedlist_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedListAdapter extends TypeAdapter<SavedList> {
  @override
  final int typeId = 2;

  @override
  SavedList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedList(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      listname: fields[2] as String,
      diaryEntryIds: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.listname)
      ..writeByte(3)
      ..write(obj.diaryEntryIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
