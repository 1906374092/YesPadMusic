import 'package:audioplayers/audioplayers.dart';
import 'package:yes_play_music/api/index.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/player/models/audio_model.dart';

class MusicPlayerRepository {
  final AudioPlayer audioPlayer;
  MusicPlayerRepository({required this.audioPlayer});
  Future<AudioModel> getMusicInfoRequest(SongDetailModel song) async {
    Map result = await API.playList.getAudioUrl(songId: song.id);
    return AudioModel.fromMap(result['data'][0], song);
  }

  playMusicWithUrl(String url) async {
    await audioPlayer.play(UrlSource(url));
  }
}
