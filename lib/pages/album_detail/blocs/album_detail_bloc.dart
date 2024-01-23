import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/album_detail/data/album_repository.dart';
import 'package:yes_play_music/pages/album_detail/models/album_detail_model.dart';

sealed class AlbumState extends Equatable {
  final AlbumDetailModel? model;
  const AlbumState({this.model});
  AlbumState copyWith({AlbumDetailModel? newModel});
}

class CommonAlbumState extends AlbumState {
  const CommonAlbumState({super.model});
  @override
  AlbumState copyWith({AlbumDetailModel? newModel}) {
    return CommonAlbumState(model: newModel ?? model);
  }

  @override
  List<Object?> get props => [model];
}

sealed class AlbumEvent {}

class AlbumGetDataEvent extends AlbumEvent {
  final int id;
  AlbumGetDataEvent({required this.id});
}

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository repository;
  AlbumBloc({required this.repository}) : super(const CommonAlbumState()) {
    on<AlbumGetDataEvent>((event, emit) {
      
    });
  }
}
