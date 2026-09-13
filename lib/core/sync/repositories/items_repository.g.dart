// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_repository.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class BackupItemAdapter extends TypeAdapter<BackupItem> {
  @override
  final typeId = 0;

  @override
  BackupItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BackupItem(
      id: fields[0] as String,
      path: fields[1] as String,
      folderName: fields[2] as String,
      createdAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BackupItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.folderName)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackupItemAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
