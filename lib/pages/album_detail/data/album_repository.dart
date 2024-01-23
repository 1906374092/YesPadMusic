import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/album_detail/models/album_detail_model.dart';

class AlbumRepository {
  Future<AlbumDetailModel> getAlbumDetailRequest({required int id}) async {
    Map result = await API.album.getAlbumDetail(id: id);
    return AlbumDetailModel.fromMap(result);
  }
}
