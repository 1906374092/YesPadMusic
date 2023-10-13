import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/utils/tools.dart';

class AlbumModel {
  final num id;
  final String name;
  final String picUrl;
  final ArtistModel? artist;
  AlbumModel(
      {required this.id,
      required this.name,
      required this.picUrl,
      this.artist});

  factory AlbumModel.fromMap(Map map) {
    return AlbumModel(
        id: map['id'],
        name: map['name'],
        picUrl: Tools.imageTransfer(map['picUrl']),
        artist: map.containsKey('artist')
            ? ArtistModel.fromMap(map['artist'])
            : null);
  }
}
