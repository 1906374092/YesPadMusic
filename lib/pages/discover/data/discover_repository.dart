import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/discover/models/category_model.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';

class DiscoverRepository {
  //获取歌单分类
  Future<List<CategoryModel>> getPlaylistCategoryRequest() async {
    Map result = await API.dicover.getPlayListCategoryRequest();
    List<CategoryModel> models = [];
    for (Map element in result['tags']) {
      models.add(CategoryModel.fromMap(element));
    }
    return models;
  }

  //根据分类获取歌单列表
  Future<List<PlayListDetailModel>> getPlaylistWithCategory(
      {required String category}) async {
    Map result = await API.dicover.getPlaylistWithCategory(category: category);
    List<PlayListDetailModel> models = [];
    for (Map element in result['playlists']) {
      models.add(PlayListDetailModel.fromMap(element));
    }
    return models;
  }
}
