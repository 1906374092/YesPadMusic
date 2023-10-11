import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yes_play_music/pages/home/data/home_repository.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/playlist_model.dart';
import 'package:yes_play_music/pages/home/models/song_model.dart';

sealed class HomeEvent {}

final class OnGetDataEvent extends HomeEvent {}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc({required this.repository}) : super(InitialState()) {
    on<OnGetDataEvent>((event, emit) async {
      try {
        List<PlayListModel> result =
            await repository.getInternetHotPlayListData();
        List<PlayListModel> personalizedModels =
            await repository.getPersonalizedPlayListData();
        List<SongModel> fmData = await repository.getPersonalFMData();
        List<ArtistModel> artistData = await repository.getTopArtistsData();
        List<AlbumModel> newAlbumListData =
            await repository.getNewAlbumListData();
        List<PlayListModel> toplist = await repository.getTopListData();
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
  }
}

@immutable
sealed class HomeState {
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
}

class SuccessState extends HomeState {
  final List<PlayListModel> hotPlaylistData;
  final List<PlayListModel> personalizedPlaylistData;
  final List<SongModel> personalFMData;
  final List<ArtistModel> artistListData;
  final List<AlbumModel> newAlbumListData;
  final List<PlayListModel> topListData;
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
}
