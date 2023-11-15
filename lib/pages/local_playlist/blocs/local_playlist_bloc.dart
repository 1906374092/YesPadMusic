import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/utils/database.dart';

sealed class LocalPlaylistState {
  final List songList;
  final SongDetailModel? current;
  const LocalPlaylistState({required this.songList, this.current});
  LocalPlaylistState copyWith({List? newList, SongDetailModel? newCurrent});
}

class CommonLocalPlaylistState extends LocalPlaylistState {
  const CommonLocalPlaylistState({required super.songList, super.current});

  // @override
  // List<Object?> get props => [songList, current];

  @override
  LocalPlaylistState copyWith({List? newList, SongDetailModel? newCurrent}) {
    return CommonLocalPlaylistState(
        songList: newList ?? songList, current: newCurrent ?? current);
  }
}

@immutable
sealed class LocalPlaylistEvent {}

class PlaylistGetLocalDataEvent extends LocalPlaylistEvent {}

class PlaylistDeleteItemEvent extends LocalPlaylistEvent {
  final SongDetailModel song;
  PlaylistDeleteItemEvent({required this.song});
}

class LocalPlaylistBloc extends Bloc<LocalPlaylistEvent, LocalPlaylistState> {
  LocalPlaylistBloc() : super(const CommonLocalPlaylistState(songList: [])) {
    on<PlaylistGetLocalDataEvent>((event, emit) {
      List<dynamic> songList = HiveBase.getSongModelList();
      emit(state.copyWith(
          newList: songList, newCurrent: HiveBase.getCurrentPlayingSong()));
    });
    on<PlaylistDeleteItemEvent>((event, emit) {
      HiveBase.songModelListDeleteSong(event.song);
      add(PlaylistGetLocalDataEvent());
    });
  }
}
