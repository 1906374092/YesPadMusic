class LoginModel {
  final num code;
  final String message;
  final String cookie;
  LoginModel({required this.code, required this.message, required this.cookie});
  factory LoginModel.fromMap(Map map) {
    return LoginModel(
        code: map['code'],
        message: map['message'],
        cookie: map['cookie'] ?? '');
  }
}
