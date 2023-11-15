import 'package:yes_play_music/api/client.dart';

class PlayListApi {
  //获取歌单详情1
  Future<Map> getPlayListDetail(
      {required num playListId, int? limit = 20, int? page = 0}) async {
    return await HttpManager.instance.get(
        '/playlist/track/all?id=$playListId&limit=$limit&offset=${page! * limit!}');
  }

  //获取歌曲播放链接
  Future<Map> getAudioUrl(
      {required num songId, String? level = 'standard'}) async {
    return await HttpManager.instance
        .get('/song/url/v1?id=$songId&level=$level');
  }

  //获取歌词
  Future<Map> getLyrics({required num songId}) async {
    return await HttpManager.instance.get('/lyric/new?id=$songId');
  }

  //获取歌单详情2
  Future<Map> getPlaylistDetailSongs({required num id}) async {
    return await HttpManager.instance.get('/playlist/detail?id=$id');
  }

  //根据歌曲id获取歌曲详情
  Future<Map> getSongDetailByIds({required String ids}) async {
    return await HttpManager.instance.get('/song/detail?ids=$ids');
  }
}
