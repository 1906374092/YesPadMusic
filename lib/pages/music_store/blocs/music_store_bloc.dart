import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/music_store/data/music_store_repository.dart';
import 'package:yes_play_music/pages/user/models/user_model.dart';

sealed class MusicStoreState extends Equatable {
  final List<SongDetailModel> likedSongs;
  final List<PlayListDetailModel> createPlaylists;
  const MusicStoreState(
      {required this.likedSongs, required this.createPlaylists});
  MusicStoreState copyWith(
      {List<SongDetailModel>? newLikedSongs,
      List<PlayListDetailModel>? newCreatePlaylists});
}

class CommonMusicStoreState extends MusicStoreState {
  const CommonMusicStoreState(
      {required super.likedSongs, required super.createPlaylists});
  @override
  List<Object?> get props => [likedSongs, createPlaylists];

  @override
  MusicStoreState copyWith(
      {List<SongDetailModel>? newLikedSongs,
      List<PlayListDetailModel>? newCreatePlaylists}) {
    return CommonMusicStoreState(
        likedSongs: newLikedSongs ?? likedSongs,
        createPlaylists: newCreatePlaylists ?? createPlaylists);
  }
}

@immutable
sealed class MusicStoreEvent {}

class MusicStoreGetDataEvent extends MusicStoreEvent {
  final UserModel user;
  MusicStoreGetDataEvent({required this.user});
}

class MusicStoreGetUserCreatePlaylistEvent extends MusicStoreEvent {
  final UserModel user;
  MusicStoreGetUserCreatePlaylistEvent({required this.user});
}

class MusicStoreBloc extends Bloc<MusicStoreEvent, MusicStoreState> {
  final MusicStoreRepository repository;
  MusicStoreBloc({required this.repository})
      : super(
            const CommonMusicStoreState(likedSongs: [], createPlaylists: [])) {
    on<MusicStoreGetDataEvent>((event, emit) async {
      String likedIds =
          await repository.getUserLikeIdsRequest(userId: event.user.userId);
      List<SongDetailModel> songs =
          await repository.getSongDetailWithIdsRequest(ids: likedIds);
      emit(state.copyWith(newLikedSongs: songs));
    });
    on<MusicStoreGetUserCreatePlaylistEvent>((event, emit) async {
      List<PlayListDetailModel> models = await repository
          .getUserCreatePlaylistRequest(userId: event.user.userId);
      emit(state.copyWith(newCreatePlaylists: models));
    });
  }
}
