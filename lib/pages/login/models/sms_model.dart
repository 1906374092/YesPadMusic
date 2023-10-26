class SMSSentModel {
  final num code;
  final bool data;
  final String message;
  SMSSentModel({required this.code, required this.data, required this.message});
  factory SMSSentModel.fromMap(Map map) {
    return SMSSentModel(
        code: map['code'], data: map['data'], message: map['message'] ?? '');
  }
}
