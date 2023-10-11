class ArtistModel {
  final num id;
  final String name;
  final String picUrl;
  ArtistModel({required this.id, required this.name, required this.picUrl});
  factory ArtistModel.fromMap(Map map) {
    return ArtistModel(id: map['id'], name: map['name'], picUrl: map['picUrl']);
  }
}
