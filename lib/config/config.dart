import 'package:permission_handler/permission_handler.dart';
import 'package:yes_play_music/utils/global.dart';

class Config {
  static const bool DEBUG = true;
  Config();
  void setup() {
    requestPermission();
  }

  void requestPermission() async {
    if (await Permission.audio.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }
    await Permission.videos.shouldShowRequestRationale;
    await Permission.audio.shouldShowRequestRationale;

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses =
        await [Permission.videos, Permission.audio].request();
    logger.i(statuses[Permission.audio]);
    logger.i(statuses[Permission.videos]);
  }
}
