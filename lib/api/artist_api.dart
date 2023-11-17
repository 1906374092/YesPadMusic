import 'package:yes_play_music/api/client.dart';

class ArtistApi {
  //艺人详情
  Future<Map> getArtistDetail({required num id}) async {
    return await HttpManager.instance.get('/artists?id=$id');
  }

  //歌手专辑
  Future<Map> getArtistAlbums({required num id, int? limit = 10}) async {
    return await HttpManager.instance.get('/artist/album?id=$id&limit=$limit');
  }

  //相似歌手
  Future<Map> getSimilarArtists({required num id}) async {
    return await HttpManager.instance.get('/simi/artist?id=$id');
  }
}
