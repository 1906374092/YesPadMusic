import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/utils/eventbus.dart';
import 'package:yes_play_music/utils/global.dart';

class ShowMiniPlayerBarNotification {}

class CookieBase {
  static String? cookie;
  static Future saveCookie(String cookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CookieBase.cookie = cookie;
    prefs.setString('cookie', cookie);
  }

  static Future<String?> getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CookieBase.cookie = prefs.getString('cookie');
    return prefs.getString('cookie');
  }

  static Future removeCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.remove('cookie');
      CookieBase.cookie = null;
    } catch (e) {
      logger.e(e);
    }
  }
}

class SettingBase {
  static Future setDarkTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
  }

  static Future<bool> getDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }
}

class HiveBase {
  static const String boxKey = 'UniversalBox';
  static const String songListKey = 'songListKey';
  static const String currentSongKey = 'currentSongKey';
  static late final Box _songBox;
  static initBase() async {
    Hive.registerAdapter<SongDetailModel>(SongDetailModelAdapter());
    Hive.registerAdapter<AlbumModel>(AlbumModelAdapter());
    Hive.registerAdapter<ArtistModel>(ArtistModelAdapter());
    await Hive.initFlutter();

    _songBox = await Hive.openBox(boxKey);
    //通知播放器列表有音乐，显示迷你播放条
    if (HiveBase.getSongModelList().isNotEmpty) {
      CommonEventBus.instance
          .fire<ShowMiniPlayerBarNotification>(ShowMiniPlayerBarNotification());
    }
  }

  static addSongModel(SongDetailModel song) async {
    List<dynamic> list = HiveBase._songBox.get(songListKey) ?? [];
    if (list.contains(song)) return;
    list.add(song);
    await HiveBase._songBox.put(songListKey, list);
  }

  static List<dynamic> getSongModelList() {
    return HiveBase._songBox.get(songListKey) ?? [];
  }

  static songModelListDeleteSong(SongDetailModel song) {
    List<dynamic> list = HiveBase._songBox.get(songListKey) ?? [];
    list.remove(song);
    HiveBase._songBox.put(songListKey, list);
  }

  static setCurruntPlayingSong(SongDetailModel song) async {
    await HiveBase._songBox.put(currentSongKey, song);
  }

  static getCurrentPlayingSong() {
    return HiveBase._songBox.get(currentSongKey);
  }
}
