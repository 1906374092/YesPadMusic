import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/home/models/song_model.dart';

class HomeRepository {
  //网友推荐
  Future<List<PlayListDetailModel>> getInternetHotPlayListData() async {
    Map result = await API.home.getInternetHotPlaylist();
    List<PlayListDetailModel> models = [];
    for (Map element in result['playlists']) {
      models.add(PlayListDetailModel.fromMap(element));
    }
    return models;
  }

  //推荐歌单
  Future<List<PlayListDetailModel>> getPersonalizedPlayListData() async {
    Map result = await API.home.getPersonalizedPlayList();
    List<PlayListDetailModel> models = [];
    for (Map element in result['result']) {
      models.add(PlayListDetailModel.fromMap(element));
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
  Future<List<PlayListDetailModel>> getTopListData() async {
    Map result = await API.home.getTopList();
    List<PlayListDetailModel> models = [];
    List<dynamic> datalist = result['list'];
    datalist.shuffle();
    for (Map element in datalist) {
      models.add(PlayListDetailModel.fromMap(element));
    }
    return models;
  }

  //歌单详情
  Future<List<SongDetailModel>> getPlayListDetail(
      {required num playListId}) async {
    Map result = await API.playList.getPlayListDetail(playListId: playListId);
    List<SongDetailModel> models = [];
    for (Map element in result['songs']) {
      models.add(SongDetailModel.fromMap(element));
    }
    return models;
  }
}
