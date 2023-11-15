import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yes_play_music/utils/colorutil.dart';
import 'package:yes_play_music/utils/database.dart';

sealed class ThemeEvent {}

final class LightThemeEvent extends ThemeEvent {}

final class DarkThemeEvent extends ThemeEvent {}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState()) {
    on<LightThemeEvent>((event, emit) async {
      await SettingBase.setDarkTheme(false);
      emit(LightThemeState());
    });
    on<DarkThemeEvent>((event, emit) async {
      await SettingBase.setDarkTheme(true);
      emit(DarkThemeState());
    });
  }
}

@immutable
sealed class ThemeState {
  get backgroundColor;
  get mainTextColor;
  get indicatorColor;
  get secondTextColor;
  get lightBlueColor;
  get darkBlueColor;
  get settingBgColor;
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
  @override
  get lightBlueColor => ColorUtil.fromHex('#b3c5fd');
  @override
  get darkBlueColor => ColorUtil.fromHex('#304de3');

  @override
  get settingBgColor => ColorUtil.fromHex('#f3f3f6');
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
  @override
  get lightBlueColor => ColorUtil.fromHex('#b3c5fd');
  @override
  get darkBlueColor => ColorUtil.fromHex('#304de3');

  @override
  get settingBgColor => ColorUtil.fromHex('#2c2c2c');
}
