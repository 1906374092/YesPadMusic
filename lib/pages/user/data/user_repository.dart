import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/user/models/user_model.dart';

class UserRepository {
  Future<UserModel> getUserAccount() async {
    Map result = await API.user.getUserAccount();

    return UserModel.fromMap(result['profile']);
  }
}
