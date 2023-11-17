import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/artist/data/artist_repository.dart';
import 'package:yes_play_music/pages/artist/models/artist_detail_model.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';

sealed class ArtistState extends Equatable {
  final ArtistDetailModel? model;
  final List<AlbumModel> albums;
  final List<ArtistModel> similarArtists;
  const ArtistState(
      {this.model, required this.albums, required this.similarArtists});
  ArtistState copyWith(
      {ArtistDetailModel? newModel,
      List<AlbumModel>? newAlbums,
      List<ArtistModel>? newSimilarArtists});
}

class CommonArtistState extends ArtistState {
  const CommonArtistState(
      {super.model, required super.albums, required super.similarArtists});

  @override
  List<Object?> get props => [model, albums];

  @override
  ArtistState copyWith(
      {ArtistDetailModel? newModel,
      List<AlbumModel>? newAlbums,
      List<ArtistModel>? newSimilarArtists}) {
    return CommonArtistState(
        model: newModel ?? model,
        albums: newAlbums ?? albums,
        similarArtists: newSimilarArtists ?? similarArtists);
  }
}

@immutable
sealed class ArtistEvent {}

class ArtistGetDataEvent extends ArtistEvent {
  final num id;
  ArtistGetDataEvent({required this.id});
}

class ArtistGetHotAlbumsEvent extends ArtistEvent {
  final num id;
  ArtistGetHotAlbumsEvent({required this.id});
}

class ArtistGetSimilarArtistsEvent extends ArtistEvent {
  final num id;
  ArtistGetSimilarArtistsEvent({required this.id});
}

class ArtistBloc extends Bloc<ArtistEvent, ArtistState> {
  final ArtistRepository repository;
  ArtistBloc({required this.repository})
      : super(const CommonArtistState(albums: [], similarArtists: [])) {
    on<ArtistGetDataEvent>((event, emit) async {
      ArtistDetailModel model =
          await repository.getArtistDetailRequest(id: event.id);
      emit(state.copyWith(newModel: model));
    });

    on<ArtistGetHotAlbumsEvent>((event, emit) async {
      List<AlbumModel> models =
          await repository.getArtistAlbumsRequest(id: event.id);
      emit(state.copyWith(newAlbums: models));
    });

    on<ArtistGetSimilarArtistsEvent>((event, emit) async {
      List<ArtistModel> models =
          await repository.getSimilarArtistRequest(id: event.id);
      emit(state.copyWith(newSimilarArtists: models));
    });
  }
}
