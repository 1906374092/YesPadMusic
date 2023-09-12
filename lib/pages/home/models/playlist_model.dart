class PlayListModel {
  final String name;
  final num id;
  final String coverImgUrl;

  PlayListModel(
      {required this.name, required this.id, required this.coverImgUrl});

  factory PlayListModel.fromMap(Map map) {
    return PlayListModel(
        name: map['name'],
        id: map['id'],
        coverImgUrl: map['coverImgUrl'] ?? map['picUrl']);
  }
}
