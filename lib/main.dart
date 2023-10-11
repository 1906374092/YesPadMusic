import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/auth.dart';
import 'package:yes_play_music/blocs/theme.dart';
import 'package:yes_play_music/pages/player/player_bar.dart';
import 'package:yes_play_music/pages/root.dart';
import 'package:yes_play_music/router/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _router = AppRouter();
  static final _authBloc = AuthBloc();
  static final _themeBloc = ThemeBloc();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _themeBloc)
      ],
      child: MaterialApp(
        title: 'Yes Play Music',
        onGenerateRoute: _router.onGenerateRoute,
        home: const Stack(
          alignment: Alignment.bottomCenter,
          children: [RootPage(), PlayerBar()],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    _themeBloc.close();
    _router.dispose();
    super.dispose();
  }
}
