import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yes_play_music/pages/home/data/home_repository.dart';
import 'package:yes_play_music/pages/home/models/playlist_model.dart';

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
        emit(SuccessState(
            hotPlaylistData: result,
            personalizedPlaylistData: personalizedModels));
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
}

class InitialState extends HomeState {
  @override
  get hotPlayList => [];
  @override
  get personalizedPlayList => [];
}

class SuccessState extends HomeState {
  final List<PlayListModel> hotPlaylistData;
  final List<PlayListModel> personalizedPlaylistData;
  SuccessState(
      {required this.hotPlaylistData, required this.personalizedPlaylistData});

  @override
  get hotPlayList => hotPlaylistData;

  @override
  get personalizedPlayList => personalizedPlaylistData;
}

class ErrorState extends HomeState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
  @override
  get hotPlayList => [];

  @override
  get personalizedPlayList => [];
}
