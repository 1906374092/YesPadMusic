import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yes_play_music/utils/colorutil.dart';

sealed class ThemeEvent {}

final class LightThemeEvent extends ThemeEvent {}

final class DarkThemeEvent extends ThemeEvent {}

class ThemeBlock extends Bloc<ThemeEvent, ThemeState> {
  ThemeBlock() : super(LightThemeState()) {
    on<LightThemeEvent>((event, emit) => emit(LightThemeState()));
    on<DarkThemeEvent>((event, emit) => emit(DarkThemeState()));
  }
}

@immutable
sealed class ThemeState {
  get backgroundColor;
  get mainTextColor;
  get indicatorColor;
  get secondTextColor;
}

final class LightThemeState extends ThemeState {
  @override
  get backgroundColor => ColorUtil.fromHex('#FFFFFF');

  @override
  get mainTextColor => ColorUtil.fromHex('#000000');
  @override
  get indicatorColor => ColorUtil.fromHex('#2A46E5');
  @override
  get secondTextColor => ColorUtil.fromHex('#adadad');
}

final class DarkThemeState extends ThemeState {
  @override
  get backgroundColor => ColorUtil.fromHex('#1A1A1A');
  @override
  get mainTextColor => ColorUtil.fromHex('#FFFFFF');
  @override
  get indicatorColor => ColorUtil.fromHex('#2742E4');
  @override
  get secondTextColor => ColorUtil.fromHex('#adadad');
}
