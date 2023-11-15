import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
part 'song_detail_model.g.dart';

@HiveType(typeId: 1, adapterName: 'SongDetailModelAdapter')
class SongDetailModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<ArtistModel> artists;
  @HiveField(3)
  final AlbumModel album;
  @HiveField(4)
  final int durationTime;

  ///0: 免费或无版权
  ///1: VIP 歌曲
  ///4: 购买专辑
  ///8: 非会员可免费播放低音质，会员可播放高音质及下载
  ///fee 为 1 或 8 的歌曲均可单独购买 2 元单曲
  @HiveField(5)
  final int fee;
  SongDetailModel(
      {required this.id,
      required this.name,
      required this.artists,
      required this.album,
      required this.durationTime,
      required this.fee});
  factory SongDetailModel.fromMap(Map map) {
    List<ArtistModel> artists = [];
    for (Map element in map['ar']) {
      artists.add(ArtistModel.fromMap(element));
    }
    return SongDetailModel(
        id: map['id'],
        name: map['name'],
        artists: artists,
        album: AlbumModel.fromMap(map['al']),
        durationTime: map['dt'],
        fee: map['fee']);
  }

  @override
  List<Object?> get props => [id, name, artists, album];
}
