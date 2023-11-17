import 'package:yes_play_music/api/album_api.dart';
import 'package:yes_play_music/api/artist_api.dart';
import 'package:yes_play_music/api/discover_api.dart';
import 'package:yes_play_music/api/homeapi.dart';
import 'package:yes_play_music/api/login_api.dart';
import 'package:yes_play_music/api/playlist_api.dart';
import 'package:yes_play_music/api/user_api.dart';

class API {
  static final home = HomeApi();
  static final login = LoginApi();
  static final user = UserApi();
  static final playList = PlayListApi();
  static final dicover = DiscoverAPI();
  static final artist = ArtistApi();
  static final album = AlbumApi();
}
