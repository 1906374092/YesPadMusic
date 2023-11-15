// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongDetailModelAdapter extends TypeAdapter<SongDetailModel> {
  @override
  final int typeId = 1;

  @override
  SongDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongDetailModel(
      id: fields[0] as int,
      name: fields[1] as String,
      artists: (fields[2] as List).cast<ArtistModel>(),
      album: fields[3] as AlbumModel,
      durationTime: fields[4] as int,
      fee: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SongDetailModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artists)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.durationTime)
      ..writeByte(5)
      ..write(obj.fee);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
