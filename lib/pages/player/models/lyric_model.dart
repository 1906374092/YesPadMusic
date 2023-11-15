import 'package:yes_play_music/utils/tools.dart';

class LyricModel {
  final num timeLable;
  final String lyric;
  LyricModel({required this.timeLable, required this.lyric});
  factory LyricModel.fromString(String content) {
    List temp = content.split(']');
    String timeStr = (temp[0] as String).substring(1);
    return LyricModel(
        timeLable: Tools.timeCountFromString(timeStr), lyric: temp[1]);
  }
}
