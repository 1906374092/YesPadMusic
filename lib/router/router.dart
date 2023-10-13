import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/login/blocs/login_page_bloc.dart';
import 'package:yes_play_music/pages/login/login.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
                  create: (context) => LoginFormBloc(),
                  child: const LoginPage(),
                ));
      default:
    }
    return null;
  }

  void dispose() {}
}
