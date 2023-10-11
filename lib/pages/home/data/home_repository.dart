import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/playlist_model.dart';
import 'package:yes_play_music/pages/home/models/song_model.dart';

class HomeRepository {
  //网友推荐
  Future<List<PlayListModel>> getInternetHotPlayListData() async {
    Map result = await API.home.getInternetHotPlaylist();
    List<PlayListModel> models = [];
    for (Map element in result['playlists']) {
      models.add(PlayListModel.fromMap(element));
    }
    return models;
  }

  //推荐歌单
  Future<List<PlayListModel>> getPersonalizedPlayListData() async {
    Map result = await API.home.getPersonalizedPlayList();
    List<PlayListModel> models = [];
    for (Map element in result['result']) {
      models.add(PlayListModel.fromMap(element));
    }
    return models;
  }

  //私人FM
  Future<List<SongModel>> getPersonalFMData() async {
    Map result = await API.home.getPersonalFM();
    List<SongModel> models = [];
    for (Map element in result['data']) {
      models.add(SongModel.fromMap(element));
    }
    return models;
  }

  //推荐艺人
  Future<List<ArtistModel>> getTopArtistsData() async {
    Map result = await API.home.getTopArtists();
    List<ArtistModel> models = [];
    List<dynamic> datalist = result['list']['artists'];
    datalist.shuffle();
    for (Map element in datalist) {
      models.add(ArtistModel.fromMap(element));
    }
    return models;
  }

  //新专速递
  Future<List<AlbumModel>> getNewAlbumListData() async {
    Map result = await API.home.getNewAlbumList();
    List<AlbumModel> models = [];
    for (Map element in result['albums']) {
      models.add(AlbumModel.fromMap(element));
    }
    return models;
  }

  //排行榜
  Future<List<PlayListModel>> getTopListData() async {
    Map result = await API.home.getTopList();
    List<PlayListModel> models = [];
    List<dynamic> datalist = result['list'];
    datalist.shuffle();
    for (Map element in datalist) {
      models.add(PlayListModel.fromMap(element));
    }
    return models;
  }
}
