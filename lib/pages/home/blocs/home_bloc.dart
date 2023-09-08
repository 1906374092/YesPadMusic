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
        emit(SuccessState(hotPlaylistData: result));
      } catch (e) {
        emit(ErrorState(errorMessage: '请求失败请稍后再试'));
      }
    });
  }
}

@immutable
sealed class HomeState {
  get hotPlayList;
}

class InitialState extends HomeState {
  @override
  get hotPlayList => [];
}

class SuccessState extends HomeState {
  final List<PlayListModel> hotPlaylistData;
  SuccessState({required this.hotPlaylistData});

  @override
  get hotPlayList => hotPlaylistData;
}

class ErrorState extends HomeState {
  final String errorMessage;
  ErrorState({required this.errorMessage});
  @override
  get hotPlayList => [];
}
