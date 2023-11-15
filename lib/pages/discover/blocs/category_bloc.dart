import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/discover/data/discover_repository.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';

sealed class CategoryInfoState extends Equatable {
  final List<PlayListDetailModel> playlists;
  const CategoryInfoState({required this.playlists});
  CategoryInfoState copyWith(List<PlayListDetailModel>? newPlaylists);
}

class CommonCategoryInfoState extends CategoryInfoState {
  const CommonCategoryInfoState({required super.playlists});
  @override
  List<Object?> get props => [];

  @override
  CategoryInfoState copyWith(List<PlayListDetailModel>? newPlaylists) {
    return CommonCategoryInfoState(playlists: newPlaylists ?? playlists);
  }
}

@immutable
sealed class CategoryInfoEvent {}

class GetPlaylistDataWithCategoryEvent extends CategoryInfoEvent {
  final String category;
  GetPlaylistDataWithCategoryEvent({required this.category});
}

class CategoryInfoBloc extends Bloc<CategoryInfoEvent, CategoryInfoState> {
  final DiscoverRepository repository;
  CategoryInfoBloc({required this.repository})
      : super(const CommonCategoryInfoState(playlists: [])) {
    on<GetPlaylistDataWithCategoryEvent>((event, emit) async {
      List<PlayListDetailModel> models =
          await repository.getPlaylistWithCategory(category: event.category);
      emit(state.copyWith(models));
    });
  }
}
