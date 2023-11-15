import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/player/models/audio_model.dart';
import 'package:yes_play_music/pages/player/models/lyric_model.dart';

class MusicPlayerRepository {
  final AudioPlayer audioPlayer;
  MusicPlayerRepository({required this.audioPlayer});
  Future<AudioModel> getMusicInfoRequest(SongDetailModel song) async {
    Map result = await API.playList.getAudioUrl(songId: song.id);
    return AudioModel.fromMap(result['data'][0], song);
  }

  Future<List<LyricModel>> getLiricsRequest(SongDetailModel song) async {
    try {
      Map result = await API.playList.getLyrics(songId: song.id);
      String lyrcs = result['lrc']['lyric'];
      List<String> lines = lyrcs.split('\n');
      List<LyricModel> models = [];
      for (String element in lines) {
        if (element.isEmpty) continue;
        models.add(LyricModel.fromString(element));
      }
      return models;
    } catch (e) {
      EasyLoading.showError(e.toString());
      return [];
    }
  }

  playMusicWithUrl(String url) async {
    try {
      await audioPlayer.play(UrlSource(url));
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  palseMusic() async {
    await audioPlayer.pause();
  }

  continuePlayMusic() async {
    await audioPlayer.resume();
  }
}
