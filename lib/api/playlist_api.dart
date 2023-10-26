import 'package:yes_play_music/api/client.dart';

class PlayListApi {
  //获取歌单详情
  Future<Map> getPlayListDetail(
      {required num playListId, int? limit = 10, int? offset = 1}) async {
    return await HttpManager.instance
        .get('/playlist/track/all?id=$playListId&limit=$limit&offset=$offset');
  }

  //获取歌曲播放链接
  Future<Map> getAudioUrl(
      {required num songId, String? level = 'standard'}) async {
    return await HttpManager.instance
        .get('/song/url/v1?id=$songId&level=$level');
  }
}
