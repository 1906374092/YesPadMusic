import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:yes_play_music/utils/tools.dart';
part 'artist_model.g.dart';

@HiveType(typeId: 2, adapterName: 'ArtistModelAdapter')
class ArtistModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
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
  static String getArtistStrings(List<ArtistModel> models) {
    List<String> artists = [];

    if (models.isNotEmpty) {
      for (ArtistModel element in models) {
        artists.add(element.name);
      }
      return artists.join(',');
    } else {
      return '';
    }
  }

  @override
  List<Object?> get props => [id, name, picUrl];
}
