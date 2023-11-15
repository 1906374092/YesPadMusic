import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/user/models/user_model.dart';
import 'package:yes_play_music/utils/tools.dart';

class PlayListDetailModel {
  final num id;
  final String name;
  final num userId;
  final num createTime;
  final num updateTime;
  final num subscribedCount;
  final String coverImgUrl;
  final String description;
  final num playCount;
  final String tag;
  final UserModel? creator;
  final num trackCount;
  final List<SongDetailModel>? tracks;

  PlayListDetailModel(
      {required this.id,
      required this.name,
      required this.userId,
      required this.createTime,
      required this.updateTime,
      required this.subscribedCount,
      required this.coverImgUrl,
      required this.description,
      required this.playCount,
      required this.tag,
      this.creator,
      required this.trackCount,
      this.tracks});

  factory PlayListDetailModel.fromMap(Map map) {
    List<SongDetailModel> tracks = [];
    if (map['tracks'] != null) {
      for (Map element in map['tracks']) {
        tracks.add(SongDetailModel.fromMap(element));
      }
    }
    return PlayListDetailModel(
        id: map['id'],
        name: map['name'],
        userId: map['userId'] ?? 0,
        createTime: map['createTime'] ?? 0,
        updateTime: map['updateTime'] ?? 0,
        subscribedCount: map['subscribedCount'] ?? 0,
        coverImgUrl: map['coverImgUrl'] != null
            ? Tools.imageTransfer(map['coverImgUrl'])
            : Tools.imageTransfer(map['picUrl']),
        description: map['description'] ?? '',
        playCount: map['playCount'] ?? 0,
        tag: map['tag'] ?? '',
        trackCount: map['trackCount'] ?? 0,
        creator:
            map['creator'] == null ? null : UserModel.fromMap(map['creator']),
        tracks: tracks);
  }
}
