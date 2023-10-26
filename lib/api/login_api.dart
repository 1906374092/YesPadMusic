import 'package:yes_play_music/api/client.dart';
import 'package:yes_play_music/utils/tools.dart';

class LoginApi {
  ///二维码登录三接口
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

  ///邮箱登录接口
  Future<Map> emailLoginRequest(String email, String md5Password) async {
    return await HttpManager.instance.post('/login',
        params: {'email': email, 'md5_password': md5Password, 'password': ''});
  }

  ///发送短信验证码
  Future<Map> sentSMSCodeRequest(String phone) async {
    return await HttpManager.instance.get(
        '/captcha/sent?phone=$phone&timeStamp=${Tools.getNowTimeInterval()}');
  }

  ///验证短信验证码
  Future<Map> validateSMSCodeRequest(String phone, String code) async {
    return await HttpManager.instance.get(
        '/captcha/verify?phone=$phone&captcha=$code&timeStamp=${Tools.getNowTimeInterval()}');
  }

  ///手机验证码登录
  Future<Map> phoneCodeLoginRequest(String phone, String code) async {
    return await HttpManager.instance.get(
        '/login/cellphone?phone=$phone&captcha=$code&timeStamp=${Tools.getNowTimeInterval()}');
  }
}
