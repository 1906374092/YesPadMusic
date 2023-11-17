import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/utils/tools.dart';

class ArtistDetailModel {
  final num id;
  final String name;
  final String picUrl;
  final num albumSize;
  final num musicSize;
  final num mvSize;
  final String briefDesc;
  final int publishTime;
  final List<SongDetailModel> hotSongs;

  ArtistDetailModel(
      {required this.id,
      required this.name,
      required this.picUrl,
      required this.albumSize,
      required this.musicSize,
      required this.mvSize,
      required this.briefDesc,
      required this.publishTime,
      required this.hotSongs});

  factory ArtistDetailModel.fromMap(Map result) {
    Map map = result['artist'];
    List<SongDetailModel> hotSongs = [];
    if (result['hotSongs'] != null) {
      for (Map element in result['hotSongs']) {
        hotSongs.add(SongDetailModel.fromMap(element));
      }
    }

    return ArtistDetailModel(
        id: map['id'],
        name: map['name'],
        picUrl: Tools.imageTransfer(map['picUrl']),
        albumSize: map['albumSize'],
        musicSize: map['musicSize'],
        mvSize: map['mvSize'],
        briefDesc: map['briefDesc'],
        publishTime: map['publishTime'],
        hotSongs: hotSongs);
  }
}
