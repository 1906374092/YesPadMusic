import 'package:shared_preferences/shared_preferences.dart';
import 'package:yes_play_music/utils/global.dart';

class DataBase {
  static String? cookie;
  static Future saveCookie(String cookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DataBase.cookie = cookie;
    prefs.setString('cookie', cookie);
  }

  static Future<String?> getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DataBase.cookie = prefs.getString('cookie');
    return prefs.getString('cookie');
  }

  static Future removeCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.remove('cookie');
      DataBase.cookie = null;
    } catch (e) {
      logger.e(e);
    }
  }
}
