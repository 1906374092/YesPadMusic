import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/login/models/sms_model.dart';

class PhoneLoginRepository {
  Future<SMSSentModel> sentSMSCodeRequest(String phone) async {
    Map result = await API.login.sentSMSCodeRequest(phone);
    return SMSSentModel.fromMap(result);
  }

  Future<SMSSentModel> validateSMSCodeRequest(String phone, String code) async {
    Map result = await API.login.validateSMSCodeRequest(phone, code);
    return SMSSentModel.fromMap(result);
  }

  Future<SMSSentModel> loginWithSMSCodeRequest(
      String phone, String code) async {
    Map result = await API.login.phoneCodeLoginRequest(phone, code);
    return SMSSentModel.fromMap(result);
  }
}
