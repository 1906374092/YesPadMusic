import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/discover/data/discover_repository.dart';
import 'package:yes_play_music/pages/discover/models/category_model.dart';
import 'package:yes_play_music/utils/colorutil.dart';

sealed class DiscoverState extends Equatable {
  final List<Color> backgroundColor;
  final List<CategoryModel> categories;
  const DiscoverState(
      {required this.backgroundColor, required this.categories});
  DiscoverState copyWith(
      {List<Color>? newBackgroundColor, List<CategoryModel> newCategories});
}

class CommonDiscoverState extends DiscoverState {
  const CommonDiscoverState(
      {required super.backgroundColor, required super.categories});
  @override
  DiscoverState copyWith(
      {List<Color>? newBackgroundColor, List<CategoryModel>? newCategories}) {
    return CommonDiscoverState(
        backgroundColor: newBackgroundColor ?? backgroundColor,
        categories: newCategories ?? categories);
  }

  @override
  List<Object?> get props => [backgroundColor, categories];
}

@immutable
sealed class DiscoverEvent {}

class DiscoverCardScrolledEvent extends DiscoverEvent {}

class DiscoverCardGetCategoryDataEvent extends DiscoverEvent {}

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final DiscoverRepository repository;
  DiscoverBloc({required this.repository})
      : super(CommonDiscoverState(backgroundColor: [
          ColorUtil.getRandomColor(),
          ColorUtil.getRandomColor(),
          ColorUtil.getRandomColor(),
          ColorUtil.getRandomColor(),
        ], categories: const [])) {
    on<DiscoverCardScrolledEvent>((event, emit) {
      emit(state.copyWith(newBackgroundColor: [
        ColorUtil.getRandomColor(),
        ColorUtil.getRandomColor(),
        ColorUtil.getRandomColor(),
        ColorUtil.getRandomColor(),
      ]));
    });
    on<DiscoverCardGetCategoryDataEvent>((event, emit) async {
      List<CategoryModel> models =
          await repository.getPlaylistCategoryRequest();
      emit(state.copyWith(newCategories: models));
    });
  }
}
