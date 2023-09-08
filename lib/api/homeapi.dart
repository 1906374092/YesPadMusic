import 'package:yes_play_music/api/client.dart';

///api/personalized?limit=10&realIP=211.161.244.70
//推荐歌单

///api/toplist?realIP=211.161.244.70
//排行榜

///api/personal_fm?timestamp=1694052481794&realIP=211.161.244.70
//私人fm

////api/toplist/artist?realIP=211.161.244.70
///推荐艺人

////api/album/new?area=all&limit=10&realIP=211.161.244.70
///新传速递

class HomeApi {
  //网友推荐
  Future<Map> getInternetHotPlaylist() async {
    return await HttpManager.instance.get('/top/playlist?limit=5&order=hot');
  }
}
