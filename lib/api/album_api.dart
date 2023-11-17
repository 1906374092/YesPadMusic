import 'package:yes_play_music/api/client.dart';

class AlbumApi {
  //获取专辑详情
  Future<Map> getAlbumDetail({required num id}) async {
    return HttpManager.instance.get('/album?id=$id');
  }
}
