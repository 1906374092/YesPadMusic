import 'dart:convert';
import 'dart:typed_data';

import 'package:yes_play_music/api/index.dart';

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

  Future<num> checkLoginStatus() async {
    Map result = await API.login.loginCheckRequest(qrKey);
    return result['code'];
  }
}
