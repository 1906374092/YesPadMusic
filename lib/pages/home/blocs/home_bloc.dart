import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/home/data/home_repository.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/home/models/song_model.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';

sealed class HomeEvent {}

final class OnGetDataEvent extends HomeEvent {}

final class OnPlaySongWithPlayListDetailModelEvent extends HomeEvent {
  final PlayListDetailModel playListDetailModel;
  final MusicPlayerBloc musicPlayerBloc;
  OnPlaySongWithPlayListDetailModelEvent(
      {required this.playListDetailModel, required this.musicPlayerBloc});
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc({required this.repository}) : super(InitialState()) {
    on<OnGetDataEvent>((event, emit) async {
      try {
        List<PlayListDetailModel> result =
            await repository.getInternetHotPlayListData();
        List<PlayListDetailModel> personalizedModels =
            await repository.getPersonalizedPlayListData();
        List<SongModel> fmData = await repository.getPersonalFMData();
        List<ArtistModel> artistData = await repository.getTopArtistsData();
        List<AlbumModel> newAlbumListData =
            await repository.getNewAlbumListData();
        List<PlayListDetailModel> toplist = await repository.getTopListData();
        emit(SuccessState(
            hotPlaylistData: result,
            personalizedPlaylistData: personalizedModels,
            personalFMData: fmData,
            artistListData: artistData,
            newAlbumListData: newAlbumListData,
            topListData: toplist));
      } catch (e) {
        emit(ErrorState(errorMessage: '请求失败请稍后再试'));
      }
    });
    on<OnPlaySongWithPlayListDetailModelEvent>((event, emit) async {
      PlayListDetailModel model = event.playListDetailModel;
      MusicPlayerBloc musicPlayerBloc = event.musicPlayerBloc;
      List<SongDetailModel> songs =
          await repository.getPlayListDetail(playListId: model.id);
      musicPlayerBloc.add(StartPlayMusicAction(songDetail: songs[0]));
    });
  }
}

@immutable
sealed class HomeState extends Equatable {
  get hotPlayList;
  get personalizedPlayList;
  get personalFM;
  get artistList;
  get newAlbumList;
  get topList;
}

class InitialState extends HomeState {
  @override
  get hotPlayList => [];
  @override
  get personalizedPlayList => [];
  @override
  get personalFM => [];
  @override
  get artistList => [];
  @override
  get newAlbumList => [];
  @override
  get topList => [];

  @override
  List<Object?> get props => [];
}

class SuccessState extends HomeState {
  final List<PlayListDetailModel> hotPlaylistData;
  final List<PlayListDetailModel> personalizedPlaylistData;
  final List<SongModel> personalFMData;
  final List<ArtistModel> artistListData;
  final List<AlbumModel> newAlbumListData;
  final List<PlayListDetailModel> topListData;
  SuccessState(
      {required this.hotPlaylistData,
      required this.personalizedPlaylistData,
      required this.personalFMData,
      required this.artistListData,
      required this.newAlbumListData,
      required this.topListData});

  @override
  get hotPlayList => hotPlaylistData;

  @override
  get personalizedPlayList => personalizedPlaylistData;
  @override
  get personalFM => personalFMData;
  @override
  get artistList => artistListData;
  @override
  get newAlbumList => newAlbumListData;
  @override
  get topList => topListData;
  @override
  List<Object?> get props => [
        hotPlaylistData,
        personalizedPlaylistData,
        personalFMData,
        artistListData,
        newAlbumListData,
        topListData
      ];
}

class ErrorState extends HomeState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
  @override
  get hotPlayList => [];

  @override
  get personalizedPlayList => [];

  @override
  get personalFM => [];
  @override
  get artistList => [];
  @override
  get newAlbumList => [];
  @override
  get topList => [];
  @override
  List<Object?> get props => [];
}
