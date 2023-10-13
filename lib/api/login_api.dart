import 'package:yes_play_music/api/client.dart';
import 'package:yes_play_music/utils/tools.dart';

class LoginApi {
  Future<Map> getQRKeyRequest() async {
    return await HttpManager.instance
        .get('/login/qr/key?timeStamp=${Tools.getNowTimeInterval()}');
  }

  Future<Map> createQRKeyRequest(String key) async {
    return await HttpManager.instance.get(
        '/login/qr/create?key=$key&qrimg=1&timeStamp=${Tools.getNowTimeInterval()}');
  }

  Future<Map> loginCheckRequest(String key) async {
    return await HttpManager.instance.get(
        '/login/qr/check?key=$key&timeStamp=${Tools.getNowTimeInterval()}');
  }
}
