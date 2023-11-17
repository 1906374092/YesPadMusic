import 'package:yes_play_music/api/client.dart';

class HomeApi {
  //网友推荐
  Future<Map> getInternetHotPlaylist() async {
    return await HttpManager.instance.get('/top/playlist?limit=5&order=hot');
  }

  //推荐歌单
  Future<Map> getPersonalizedPlayList({int? limit}) async {
    return await HttpManager.instance.get('/personalized?limit=${limit ?? 10}');
  }

  //私人FM
  Future<Map> getPersonalFM() async {
    return await HttpManager.instance.get('/personal_fm');
  }

  //推荐艺人
  Future<Map> getTopArtists() async {
    return await HttpManager.instance.get('/toplist/artist');
  }

  //新专速递
  Future<Map> getNewAlbumList() async {
    return await HttpManager.instance.get('/album/new?area=all&limit=10');
  }

  //排行榜
  Future<Map> getTopList() async {
    return await HttpManager.instance.get('/toplist');
  }
}
