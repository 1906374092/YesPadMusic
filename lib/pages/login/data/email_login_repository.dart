import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/login/models/login_model.dart';

class EmailLoginRepository {
  Future<LoginModel> emailLoginRequest(String email, String md5Password) async {
    dynamic result = await API.login.emailLoginRequest(email, md5Password);
    return LoginModel.fromMap(result);
  }
}
