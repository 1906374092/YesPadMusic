import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yes_play_music/utils/database.dart';
import 'package:yes_play_music/utils/global.dart';

class Config {
  static const bool DEBUG = true;

  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  Config();
  void setup() {
    // requestPermission();
    initHive();
  }

  void requestPermission() async {
    if (await Permission.audio.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }
    await Permission.audio.shouldShowRequestRationale;

// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses =
        await [Permission.audio].request();
    logger.i(statuses[Permission.audio]);
  }

  void initHive() {
    HiveBase.initBase();
  }
}
