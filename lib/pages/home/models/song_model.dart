import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';

class SongModel {
  final num id;
  final String name;
  final List<ArtistModel> artists;
  final AlbumModel album;
  SongModel(
      {required this.id,
      required this.name,
      required this.artists,
      required this.album});

  factory SongModel.fromMap(Map map) {
    List<ArtistModel> artists = [];
    for (Map element in map['artists']) {
      artists.add(ArtistModel.fromMap(element));
    }
    return SongModel(
        id: map['id'],
        name: map['name'],
        artists: artists,
        album: AlbumModel.fromMap(map['album']));
  }
}
