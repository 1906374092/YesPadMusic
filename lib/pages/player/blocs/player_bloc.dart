import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/player/data/repository.dart';
import 'package:yes_play_music/pages/player/models/audio_model.dart';

///播放器相关枚举
enum LoopStatus { sequence, single, random }

///播放器状态
sealed class MusicPlayerState extends Equatable {
  final LoopStatus loopStatus;
  final PlayerState playerState;
  final AudioModel? currentAudio;

  const MusicPlayerState(
      {required this.loopStatus, this.currentAudio, required this.playerState});
}

class PlayerPlayingState extends MusicPlayerState {
  const PlayerPlayingState(
      {required super.loopStatus,
      super.currentAudio,
      required super.playerState});
  @override
  List<Object?> get props => [loopStatus, playerState, currentAudio];

  PlayerPlayingState copyWith(
      {LoopStatus? newLoopStatus,
      AudioModel? audio,
      PlayerState? newPlayStatus}) {
    return PlayerPlayingState(
        loopStatus: newLoopStatus ?? loopStatus,
        currentAudio: audio ?? currentAudio,
        playerState: newPlayStatus ?? playerState);
  }
}

class PlayerPauseState extends MusicPlayerState {
  const PlayerPauseState(
      {required super.loopStatus,
      super.currentAudio,
      required super.playerState});
  @override
  List<Object?> get props => [loopStatus, playerState, currentAudio];
  PlayerPauseState copyWith(
      {LoopStatus? newLoopStatus,
      AudioModel? audio,
      PlayerState? newPlayStatus}) {
    return PlayerPauseState(
        loopStatus: newLoopStatus ?? loopStatus,
        currentAudio: audio ?? currentAudio,
        playerState: newPlayStatus ?? playerState);
  }
}

class PlayerStopState extends MusicPlayerState {
  const PlayerStopState(
      {required super.loopStatus,
      super.currentAudio,
      required super.playerState});
  @override
  List<Object?> get props => [loopStatus];
}

///播放器事件
@immutable
sealed class MusicPlayerEvent {}

class StartPlayMusicAction extends MusicPlayerEvent {
  final SongDetailModel songDetail;
  StartPlayMusicAction({required this.songDetail});
}

///播放器bloc
class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final MusicPlayerRepository repository;
  MusicPlayerBloc({required this.repository})
      : super(const PlayerStopState(
            loopStatus: LoopStatus.sequence,
            playerState: PlayerState.stopped)) {
    on<StartPlayMusicAction>((event, emit) async {
      SongDetailModel song = event.songDetail;
      AudioModel model = await repository.getMusicInfoRequest(song);
      await repository.playMusicWithUrl(model.url);
      repository.audioPlayer.onPlayerStateChanged.listen(
        (event) {},
      );
      // emit(PlayerPlayingState(
      //     loopStatus: state.loopStatus,
      //     currentAudio: model,
      //     playerState: repository.audioPlayer.state));
    });
  }
}
