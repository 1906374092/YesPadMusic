import 'package:yes_play_music/utils/tools.dart';

class ArtistModel {
  final num id;
  final String name;
  final String picUrl;
  ArtistModel({required this.id, required this.name, required this.picUrl});
  factory ArtistModel.fromMap(Map map) {
    return ArtistModel(
        id: map['id'],
        name: map['name'],
        picUrl: map.containsKey('picUrl')
            ? Tools.imageTransfer(map['picUrl'])
            : '');
  }
}
