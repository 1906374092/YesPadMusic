import 'package:yes_play_music/api/client.dart';
import 'package:yes_play_music/utils/tools.dart';

class UserApi {
  Future<Map> getUserAccount() async {
    return await HttpManager.instance
        .get('/user/account?timeStamp=${Tools.getNowTimeInterval()}');
  }
}
