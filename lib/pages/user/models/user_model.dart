import 'package:yes_play_music/utils/tools.dart';

class UserModel {
  final num userId;
  final num userType;
  final String nickName;
  final String avatarUrl;
  final String backgroundUrl;
  final String signature;
  UserModel(
      {required this.userId,
      required this.userType,
      required this.nickName,
      required this.avatarUrl,
      required this.backgroundUrl,
      required this.signature});
  factory UserModel.fromMap(Map map) {
    return UserModel(
        userId: map['userId'],
        userType: map['userType'],
        nickName: map['nickname'],
        avatarUrl: Tools.imageTransfer(map['avatarUrl']),
        backgroundUrl: Tools.imageTransfer(map['backgroundUrl']),
        signature: map['signature']);
  }
}
