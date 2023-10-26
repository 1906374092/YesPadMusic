import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/login/models/login_model.dart';

class QRCodeLoginRepository {
  late String qrKey;

  Future<String> getQRCodeString() async {
    Map result = await API.login.getQRKeyRequest();
    qrKey = result['data']['unikey'];
    Map codeData = await API.login.createQRKeyRequest(qrKey);
    // String base64QRCode = codeData['data']['qrimg'];
    String qrUrlString = codeData['data']['qrurl'];
    // String tempCode = base64QRCode.split(',')[1];
    return qrUrlString;
  }

  Future<LoginModel> checkLoginStatus() async {
    Map result = await API.login.loginCheckRequest(qrKey);
    return LoginModel.fromMap(result);
  }
}
