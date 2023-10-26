import 'package:yes_play_music/pages/home/models/song_detail_model.dart';

class AudioModel {
  final num id;
  final String url;
  final num size;
  final String md5;
  final String type;
  final String level;
  final num time;
  final SongDetailModel songDetail;
  AudioModel(
      {required this.id,
      required this.url,
      required this.size,
      required this.md5,
      required this.type,
      required this.level,
      required this.time,
      required this.songDetail});
  factory AudioModel.fromMap(Map map, SongDetailModel songDetail) {
    return AudioModel(
        id: map['id'],
        url: map['url'],
        size: map['size'],
        md5: map['md5'],
        type: map['type'],
        level: map['level'],
        time: map['time'],
        songDetail: songDetail);
  }
}
