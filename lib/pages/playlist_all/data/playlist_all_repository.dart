import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';

class PlaylistAllRepository {
  //推荐歌单
  Future<List<PlayListDetailModel>> getPersonalizedPlayListData() async {
    Map result = await API.home.getPersonalizedPlayList(limit: 40);
    List<PlayListDetailModel> models = [];
    for (Map element in result['result']) {
      models.add(PlayListDetailModel.fromMap(element));
    }
    return models;
  }

  //根据分类获取歌单列表
  Future<List<PlayListDetailModel>> getPlaylistWithCategory(
      {required String category}) async {
    Map result = await API.dicover
        .getPlaylistWithCategory(category: category, limit: 60);
    List<PlayListDetailModel> models = [];
    for (Map element in result['playlists']) {
      models.add(PlayListDetailModel.fromMap(element));
    }
    return models;
  }
}
