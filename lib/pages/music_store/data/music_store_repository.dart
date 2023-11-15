import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';

class MusicStoreRepository {
  Future<String> getUserLikeIdsRequest({required num userId}) async {
    Map result = await API.user.getUserLikeMusicIds(userId: userId);
    return (result['ids'] as List).join(',');
  }

  Future<List<SongDetailModel>> getSongDetailWithIdsRequest(
      {required String ids}) async {
    Map result = await API.playList.getSongDetailByIds(ids: ids);
    List<SongDetailModel> songs = [];
    for (Map element in result['songs']) {
      songs.add(SongDetailModel.fromMap(element));
    }
    return songs;
  }

  Future<List<PlayListDetailModel>> getUserCreatePlaylistRequest(
      {required num userId}) async {
    Map result = await API.user.getuserCreatePlaylist(userId: userId);
    List<PlayListDetailModel> models = [];
    for (Map element in result['playlist']) {
      models.add(PlayListDetailModel.fromMap(element));
    }
    return models;
  }
}
