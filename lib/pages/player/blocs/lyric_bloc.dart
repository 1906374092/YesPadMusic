import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/player/data/repository.dart';
import 'package:yes_play_music/pages/player/models/lyric_model.dart';
import 'package:yes_play_music/utils/eventbus.dart';

class LoadLyricsNotification {
  final SongDetailModel song;
  LoadLyricsNotification({required this.song});
}

sealed class LyricState extends Equatable {
  final List<LyricModel> lyrics;
  final int currentIndex;
  const LyricState({required this.lyrics, required this.currentIndex});
  LyricShowState copyWith({List<LyricModel>? newLyrics, int? newCurrentIndex});
}

class LyricShowState extends LyricState {
  const LyricShowState({required super.lyrics, required super.currentIndex});
  @override
  List<Object?> get props => [lyrics, currentIndex];

  @override
  LyricShowState copyWith({List<LyricModel>? newLyrics, int? newCurrentIndex}) {
    return LyricShowState(
        lyrics: newLyrics ?? lyrics,
        currentIndex: newCurrentIndex ?? currentIndex);
  }
}

@immutable
sealed class LyricEvent {}

class LyricGetDataEvent extends LyricEvent {
  final SongDetailModel song;
  LyricGetDataEvent({required this.song});
}

class UpdateIndexEvent extends LyricEvent {
  final int curruntIndex;
  UpdateIndexEvent({required this.curruntIndex});
}

class LyricBloc extends Bloc<LyricEvent, LyricState> {
  final MusicPlayerRepository repository;
  LyricBloc({required this.repository})
      : super(const LyricShowState(lyrics: [], currentIndex: 1)) {
    int updateIndex = 0;
    // //监听歌曲切换
    // CommonEventBus.instance.listen<LoadLyricsNotification>((event) {
    //   add(LyricGetDataEvent(song: event.song));
    // });
    repository.audioPlayer.onPositionChanged.listen((event) {
      if (isClosed) return;
      if (state.lyrics.isEmpty) return;
      int curruntIndex = 0;
      for (int i = 0; i != state.lyrics.length; ++i) {
        LyricModel model = state.lyrics[i];
        if (i == state.lyrics.length - 1) {
          curruntIndex = state.lyrics.length - 1;
          return;
        }
        LyricModel nextModel = state.lyrics[i + 1];
        if (event.inMilliseconds >= model.timeLable &&
            event.inMilliseconds < nextModel.timeLable) {
          curruntIndex = i;
          add(UpdateIndexEvent(curruntIndex: curruntIndex));
          return;
        }
      }
    });
    on<LyricGetDataEvent>((event, emit) async {
      List<LyricModel> lyrics = await repository.getLiricsRequest(event.song);
      emit(state.copyWith(newLyrics: lyrics, newCurrentIndex: 0));
    });
    on<UpdateIndexEvent>((event, emit) {
      if (event.curruntIndex == updateIndex) return;
      emit(state.copyWith(newCurrentIndex: event.curruntIndex));
      updateIndex = event.curruntIndex;
    });
  }
}
