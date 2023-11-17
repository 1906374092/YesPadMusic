import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/playlist_detail/data/playlist_detail_repository.dart';

sealed class PlaylistDetailState extends Equatable {
  final PlayListDetailModel? model;
  final String title;
  final List<SongDetailModel> tracks;
  const PlaylistDetailState(
      {this.model, required this.title, required this.tracks});
  PlaylistDetailState copyWith(
      {PlayListDetailModel? newModel,
      String? newTitle,
      List<SongDetailModel>? newTracks});
}

class CommonPlaylistDetailState extends PlaylistDetailState {
  const CommonPlaylistDetailState(
      {super.model, required super.title, required super.tracks});
  @override
  List<Object?> get props => [model, title, tracks];

  @override
  PlaylistDetailState copyWith(
      {PlayListDetailModel? newModel,
      String? newTitle,
      List<SongDetailModel>? newTracks}) {
    return CommonPlaylistDetailState(
        model: newModel ?? model,
        title: newTitle ?? title,
        tracks: newTracks ?? tracks);
  }
}

sealed class PlaylistDetailEvent {}

class PlaylistDetailGetDataEvent extends PlaylistDetailEvent {
  final num id;
  PlaylistDetailGetDataEvent({required this.id});
}

class PlaylistDetailGetNewTracksEvent extends PlaylistDetailEvent {
  final num id;
  PlaylistDetailGetNewTracksEvent({required this.id});
}

class PlaylistDetailLoadMoreTracksEvent extends PlaylistDetailEvent {
  final num id;
  PlaylistDetailLoadMoreTracksEvent({required this.id});
}

class PlaylistDetailBloc
    extends Bloc<PlaylistDetailEvent, PlaylistDetailState> {
  final PlaylistDetailRepository repository;
  int page = 0;
  PlaylistDetailBloc({required this.repository})
      : super(const CommonPlaylistDetailState(title: '歌单', tracks: [])) {
    on<PlaylistDetailGetDataEvent>((event, emit) async {
      PlayListDetailModel model =
          await repository.getPlaylistDetailRequest(id: event.id);
      emit(state.copyWith(newModel: model));
    });
    on<PlaylistDetailGetNewTracksEvent>((event, emit) async {
      page = 0;
      List<SongDetailModel> tracks = await repository
          .getPlaylistDetalTracksRequest(id: event.id, page: page);
      emit(state.copyWith(newTracks: tracks));
    });
    on<PlaylistDetailLoadMoreTracksEvent>((event, emit) async {
      page++;
      List<SongDetailModel> tracks = await repository
          .getPlaylistDetalTracksRequest(id: event.id, page: page);
      emit(state.copyWith(newTracks: tracks));
    });
  }
}
