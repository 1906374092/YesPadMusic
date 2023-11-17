import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';

class PlaylistDetailRepository {
  Future<PlayListDetailModel> getPlaylistDetailRequest(
      {required num id}) async {
    Map result = await API.playList.getPlaylistDetailSongs(id: id);
    return PlayListDetailModel.fromMap(result['playlist']);
  }

  Future<List<SongDetailModel>> getPlaylistDetalTracksRequest(
      {required num id, required int page}) async {
    Map result =
        await API.playList.getPlayListDetail(playListId: id, page: page);
    List<SongDetailModel> models = [];
    for (Map element in result['songs']) {
      models.add(SongDetailModel.fromMap(element));
    }
    return models;
  }
}
