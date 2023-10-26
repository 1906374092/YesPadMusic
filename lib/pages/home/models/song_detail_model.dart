import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';

class SongDetailModel {
  final num id;
  final String name;
  final List<ArtistModel> artists;
  final AlbumModel album;
  SongDetailModel(
      {required this.id,
      required this.name,
      required this.artists,
      required this.album});
  factory SongDetailModel.fromMap(Map map) {
    List<ArtistModel> artists = [];
    for (Map element in map['ar']) {
      artists.add(ArtistModel.fromMap(element));
    }
    return SongDetailModel(
        id: map['id'],
        name: map['name'],
        artists: artists,
        album: AlbumModel.fromMap(map['al']));
  }
}
