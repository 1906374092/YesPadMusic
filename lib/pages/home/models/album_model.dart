import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/utils/tools.dart';
part 'album_model.g.dart';

@HiveType(typeId: 3, adapterName: 'AlbumModelAdapter')
class AlbumModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

  ///300尺寸专辑封面
  @HiveField(2)
  final String picUrl;

  ///100尺寸专辑封面
  @HiveField(3)
  final String picUrlMini;
  @HiveField(4)
  final ArtistModel? artist;
  AlbumModel(
      {required this.id,
      required this.name,
      required this.picUrl,
      required this.picUrlMini,
      this.artist});

  factory AlbumModel.fromMap(Map map) {
    return AlbumModel(
        id: map['id'],
        name: map['name'],
        picUrl: Tools.imageTransfer(map['picUrl']),
        picUrlMini: Tools.imageTransfer(map['picUrl'], size: 100),
        artist: map.containsKey('artist')
            ? ArtistModel.fromMap(map['artist'])
            : null);
  }

  @override
  List<Object?> get props => [id, name, picUrl, picUrlMini];
}
