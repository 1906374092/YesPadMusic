import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/artist/models/artist_detail_model.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';

class ArtistRepository {
  Future<ArtistDetailModel> getArtistDetailRequest({required num id}) async {
    Map result = await API.artist.getArtistDetail(id: id);
    return ArtistDetailModel.fromMap(result);
  }

  Future<List<AlbumModel>> getArtistAlbumsRequest({required num id}) async {
    Map result = await API.artist.getArtistAlbums(id: id);
    List<AlbumModel> models = [];
    for (Map element in result['hotAlbums']) {
      models.add(AlbumModel.fromMap(element));
    }
    return models;
  }

  Future<List<ArtistModel>> getSimilarArtistRequest({required num id}) async {
    Map result = await API.artist.getSimilarArtists(id: id);
    List<ArtistModel> models = [];
    for (Map element in result['artists']) {
      models.add(ArtistModel.fromMap(element));
    }
    return models;
  }
}
