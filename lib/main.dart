import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yes_play_music/blocs/auth_bloc.dart';
import 'package:yes_play_music/pages/local_playlist/components/local_playlist.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/config/config.dart';
import 'package:yes_play_music/pages/player/components/player_bar.dart';
import 'package:yes_play_music/pages/player/data/repository.dart';
import 'package:yes_play_music/pages/root.dart';
import 'package:yes_play_music/pages/user/data/user_repository.dart';
import 'package:yes_play_music/router/router.dart';
import 'package:yes_play_music/utils/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Config().setup();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _router = AppRouter();
  static final _authBloc = AuthBloc(repository: UserRepository())
    ..add(LoginEvent());
  static final _themeBloc = ThemeBloc();
  static final _musicPlayerBloc = MusicPlayerBloc(
      repository: MusicPlayerRepository(audioPlayer: AudioPlayer()));
  // 用于路由返回监听
  @override
  void initState() {
    setTheme();
    super.initState();
  }

  setTheme() async {
    bool isDark = await SettingBase.getDarkTheme();
    _themeBloc.add(isDark ? DarkThemeEvent() : LightThemeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _themeBloc),
        BlocProvider.value(value: _musicPlayerBloc)
      ],
      child: MaterialApp(
        title: 'Yes Play Music',
        onGenerateRoute: _router.onGenerateRoute,
        home: const Scaffold(
          endDrawer: LocalPlaylist(),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [RootPage(), PlayerBar()],
          ),
        ),
        builder: EasyLoading.init(),
        navigatorObservers: [Config.routeObserver],
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    _themeBloc.close();
    _router.dispose();
    _musicPlayerBloc.close();
    super.dispose();
  }
}
