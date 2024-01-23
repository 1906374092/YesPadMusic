import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';

class AlbumDetailModel {
  final num id;
  final String name;
  final String picUrl;
  final String description;
  final String type;
  final int size;
  final String company;
  final int publishTime;
  final ArtistModel artist;
  final List<ArtistModel> artists;
  final List<SongDetailModel> songs;
  AlbumDetailModel(
      {required this.id,
      required this.name,
      required this.picUrl,
      required this.description,
      required this.type,
      required this.company,
      required this.publishTime,
      required this.size,
      required this.artist,
      required this.artists,
      required this.songs});

  factory AlbumDetailModel.fromMap(Map map) {
    Map album = map['album'];
    List<ArtistModel> artists = [];
    List<SongDetailModel> songs = [];
    for (Map element in map['songs']) {
      songs.add(SongDetailModel.fromMap(element));
    }
    for (Map element in album['artists']) {
      artists.add(ArtistModel.fromMap(element));
    }
    return AlbumDetailModel(
        id: album['id'],
        name: album['name'],
        picUrl: album['picUrl'],
        description: album['description'],
        type: album['type'],
        company: album['company'],
        publishTime: album['publishTime'],
        size: album['size'],
        artist: album['artist'],
        artists: artists,
        songs: songs);
  }
}
