import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/playlist_all/data/playlist_all_repository.dart';

sealed class PlaylistAllState extends Equatable {
  final List<PlayListDetailModel> models;
  const PlaylistAllState({required this.models});
  PlaylistAllState copyWith(List<PlayListDetailModel>? newModels);
}

class CommonPLaylistAllState extends PlaylistAllState {
  const CommonPLaylistAllState({required super.models});

  @override
  PlaylistAllState copyWith(List<PlayListDetailModel>? newModels) {
    return CommonPLaylistAllState(models: newModels ?? models);
  }

  @override
  List<Object?> get props => [models];
}

@immutable
sealed class PlaylistAllEvent {}

class PlaylistAllGetDataEvent extends PlaylistAllEvent {
  final String? category;
  PlaylistAllGetDataEvent({this.category});
}

class PlaylistAllBloc extends Bloc<PlaylistAllEvent, PlaylistAllState> {
  final PlaylistAllRepository repository;
  PlaylistAllBloc({required this.repository})
      : super(const CommonPLaylistAllState(models: [])) {
    on<PlaylistAllGetDataEvent>((event, emit) async {
      if (event.category != null) {
        List<PlayListDetailModel> models =
            await repository.getPlaylistWithCategory(category: event.category!);
        emit(state.copyWith(models));
      } else {
        List<PlayListDetailModel> models =
            await repository.getPersonalizedPlayListData();
        emit(state.copyWith(models));
      }
    });
  }
}
