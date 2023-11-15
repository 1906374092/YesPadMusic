import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/player/blocs/lyric_bloc.dart';
import 'package:yes_play_music/pages/player/data/repository.dart';
import 'package:yes_play_music/pages/player/models/audio_model.dart';
import 'package:yes_play_music/utils/database.dart';
import 'package:yes_play_music/utils/eventbus.dart';

///播放器相关枚举
enum LoopStatus { sequence, single, random }

enum PlayingStatus { playing, paused }

///播放器状态
sealed class MusicPlayerState extends Equatable {
  final LoopStatus loopStatus;
  final PlayingStatus playingStatus;
  final AudioModel? currentAudio;
  final Duration? progress;

  const MusicPlayerState(
      {required this.loopStatus,
      this.currentAudio,
      required this.playingStatus,
      this.progress});
  MusicPlayerState copyWith(
      {LoopStatus? newLoopStatus,
      AudioModel? audio,
      PlayingStatus? newPlayingStatus,
      Duration? newProgress});
}

class PlayerPlayingState extends MusicPlayerState {
  const PlayerPlayingState(
      {required super.loopStatus,
      super.currentAudio,
      required super.playingStatus,
      super.progress});
  @override
  List<Object?> get props =>
      [loopStatus, playingStatus, currentAudio, progress];

  @override
  MusicPlayerState copyWith(
      {LoopStatus? newLoopStatus,
      AudioModel? audio,
      PlayingStatus? newPlayingStatus,
      Duration? newProgress}) {
    return PlayerPlayingState(
        loopStatus: newLoopStatus ?? loopStatus,
        currentAudio: audio ?? currentAudio,
        playingStatus: newPlayingStatus ?? playingStatus,
        progress: newProgress ?? progress);
  }
}

class PlayerStopState extends MusicPlayerState {
  const PlayerStopState(
      {required super.loopStatus,
      super.currentAudio,
      required super.playingStatus,
      super.progress});
  @override
  List<Object?> get props =>
      [loopStatus, currentAudio, playingStatus, progress];

  @override
  MusicPlayerState copyWith(
      {LoopStatus? newLoopStatus,
      AudioModel? audio,
      PlayingStatus? newPlayingStatus,
      Duration? newProgress}) {
    return PlayerPlayingState(
        loopStatus: newLoopStatus ?? loopStatus,
        currentAudio: audio ?? currentAudio,
        playingStatus: newPlayingStatus ?? playingStatus,
        progress: newProgress ?? progress);
  }
}

///播放器事件
@immutable
sealed class MusicPlayerEvent {}

class StartPlayMusicAction extends MusicPlayerEvent {
  final SongDetailModel songDetail;
  StartPlayMusicAction({required this.songDetail});
}

class MusicPlayCompleteEvent extends MusicPlayerEvent {}

class MusicPlayerPauseAction extends MusicPlayerEvent {}

class MusicPlayerContinueAction extends MusicPlayerEvent {}

class MusicShowPausedMiniPlayerBarAction extends MusicPlayerEvent {}

class MusicPlayerPlayNextAction extends MusicPlayerEvent {}

class MusicPlayerPlayPreviousAction extends MusicPlayerEvent {}

class MusicPlayerChangePlayOrderAction extends MusicPlayerEvent {
  final LoopStatus loopStatus;
  MusicPlayerChangePlayOrderAction({required this.loopStatus});
}

class MusicPlayerUpdateProgressAction extends MusicPlayerEvent {
  final Duration duration;
  MusicPlayerUpdateProgressAction({required this.duration});
}

///播放器bloc
class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final MusicPlayerRepository repository;
  MusicPlayerBloc({required this.repository})
      : super(const PlayerStopState(
            loopStatus: LoopStatus.sequence,
            playingStatus: PlayingStatus.paused)) {
    //初始化判断本地播放列表是否有歌曲
    CommonEventBus.instance
        .listen<ShowMiniPlayerBarNotification>((event) async {
      add(MusicShowPausedMiniPlayerBarAction());
    });
    //监听播放完成
    repository.audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        if (state.loopStatus == LoopStatus.single) {
          add(StartPlayMusicAction(songDetail: state.currentAudio!.songDetail));
        } else {
          add(MusicPlayerPlayNextAction());
        }
      }
    });
    //监听播放进度
    repository.audioPlayer.onPositionChanged.listen((event) {
      add(MusicPlayerUpdateProgressAction(duration: event));
    });
    on<StartPlayMusicAction>((event, emit) async {
      HapticFeedback.lightImpact();
      SongDetailModel song = event.songDetail;
      HiveBase.setCurruntPlayingSong(song);
      HiveBase.addSongModel(song);
      AudioModel model = await repository.getMusicInfoRequest(song);
      emit(PlayerPlayingState(
          loopStatus: state.loopStatus,
          currentAudio: model,
          playingStatus: PlayingStatus.playing));
      CommonEventBus.instance
          .fire<LoadLyricsNotification>(LoadLyricsNotification(song: song));
      await repository.playMusicWithUrl(model.url);
    });
    on<MusicPlayCompleteEvent>((event, emit) {
      emit(state.copyWith(newPlayingStatus: PlayingStatus.paused));
    });
    on<MusicPlayerPauseAction>((event, emit) async {
      HapticFeedback.lightImpact();

      emit(state.copyWith(newPlayingStatus: PlayingStatus.paused));
      await repository.palseMusic();
    });
    on<MusicPlayerContinueAction>((event, emit) async {
      HapticFeedback.lightImpact();

      emit(state.copyWith(newPlayingStatus: PlayingStatus.playing));
      if (repository.audioPlayer.state == PlayerState.stopped) {
        await repository.playMusicWithUrl(state.currentAudio!.url);
      } else {
        await repository.continuePlayMusic();
      }
    });
    on<MusicPlayerUpdateProgressAction>((event, emit) {
      emit(state.copyWith(newProgress: event.duration));
    });
    on<MusicShowPausedMiniPlayerBarAction>((event, emit) async {
      SongDetailModel song = HiveBase.getCurrentPlayingSong();
      AudioModel model = await repository.getMusicInfoRequest(song);

      emit(PlayerPlayingState(
          loopStatus: state.loopStatus,
          currentAudio: model,
          playingStatus: PlayingStatus.paused));
    });
    //上一曲，下一曲
    on<MusicPlayerPlayNextAction>((event, emit) {
      SongDetailModel song = HiveBase.getCurrentPlayingSong();
      List songList = HiveBase.getSongModelList();
      int index = songList.indexOf(song);

      if (state.loopStatus == LoopStatus.sequence ||
          state.loopStatus == LoopStatus.single) {
        int newIndex = index == songList.length - 1 ? 0 : index + 1;
        add(StartPlayMusicAction(songDetail: songList[newIndex]));
      } else if (state.loopStatus == LoopStatus.random) {
        int newIndex = Random().nextInt(songList.length);
        add(StartPlayMusicAction(songDetail: songList[newIndex]));
      }
    });
    on<MusicPlayerPlayPreviousAction>((event, emit) {
      SongDetailModel song = HiveBase.getCurrentPlayingSong();
      List songList = HiveBase.getSongModelList();
      int index = songList.indexOf(song);
      if (state.loopStatus == LoopStatus.sequence ||
          state.loopStatus == LoopStatus.single) {
        int newIndex = index == 0 ? songList.length - 1 : index - 1;
        add(StartPlayMusicAction(songDetail: songList[newIndex]));
      } else if (state.loopStatus == LoopStatus.random) {
        int newIndex = Random().nextInt(songList.length);
        add(StartPlayMusicAction(songDetail: songList[newIndex]));
      }
    });
    //切换播放顺序
    on<MusicPlayerChangePlayOrderAction>((event, emit) {
      emit(state.copyWith(newLoopStatus: event.loopStatus));
    });
  }
}
