import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/artist/components/artist_page.dart';
import 'package:yes_play_music/pages/login/blocs/login_page_bloc.dart';
import 'package:yes_play_music/pages/login/login.dart';
import 'package:yes_play_music/pages/player/components/page_route_animation.dart';
import 'package:yes_play_music/pages/player/components/player_page.dart';
import 'package:yes_play_music/pages/playlist_all/components/playlist_all.dart';
import 'package:yes_play_music/pages/playlist_detail/components/playlist_detail_page.dart';
import 'package:yes_play_music/pages/user/components/user_page.dart';

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
      case '/player_page':
        return OpenPlayerPageRoute(const PlayerPage());
      case '/playlist/detail':
        Map args = settings.arguments as Map;
        return CommonPageRoute(
          PlaylistDetailPage(name: args['title'], id: args['id']),
        );
      case '/user':
        return CommonPageRoute(const UserPage());
      case '/playlist_all':
        Map args = settings.arguments as Map;
        return CommonPageRoute(PlaylistAllPage(
          type: args['type'],
          category: args['category'],
        ));
      case '/artist_detail':
        Map args = settings.arguments as Map;
        return CommonPageRoute(ArtistPage(
          id: args['id'],
          name: args['name'],
        ));
      default:
    }
    return null;
  }

  void dispose() {}
}
