import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/home/models/playlist_model.dart';

class HomeRepository {
  Future<List<PlayListModel>> getInternetHotPlayListData() async {
    Map result = await API.home.getInternetHotPlaylist();
    List<PlayListModel> models = [];
    for (Map element in result['playlists']) {
      models.add(PlayListModel.fromMap(element));
    }
    return models;
  }
}
