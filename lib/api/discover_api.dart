import 'package:yes_play_music/api/client.dart';

class DiscoverAPI {
  //获取热门歌单分类
  Future<Map> getPlayListCategoryRequest() async {
    return await HttpManager.instance.get('/playlist/highquality/tags');
  }

  Future<Map> getPlaylistWithCategory(
      {required String category, int? limit = 5}) async {
    return await HttpManager.instance
        .get('/top/playlist/highquality?limit=$limit&cat=$category');
  }
}
