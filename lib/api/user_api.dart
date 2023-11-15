import 'package:yes_play_music/api/client.dart';
import 'package:yes_play_music/utils/tools.dart';

class UserApi {
  ///账户信息
  Future<Map> getUserAccount() async {
    return await HttpManager.instance
        .get('/user/account?timeStamp=${Tools.getNowTimeInterval()}');
  }

  ///喜欢歌曲列表
  Future<Map> getUserLikeMusicIds({required num userId}) async {
    return await HttpManager.instance.get('/likelist?uid=$userId');
  }

  ///创建的歌单
  Future<Map> getuserCreatePlaylist({required num userId}) async {
    return await HttpManager.instance.get('/user/playlist?uid=$userId');
  }
}
