import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/auth_bloc.dart';
import 'package:yes_play_music/component/footer.dart';
import 'package:yes_play_music/pages/music_store/blocs/music_store_bloc.dart';
import 'package:yes_play_music/pages/music_store/components/music_store_header.dart';
import 'package:yes_play_music/pages/music_store/components/music_store_playlists_component.dart';
import 'package:yes_play_music/pages/music_store/data/music_store_repository.dart';
import 'package:yes_play_music/pages/user/models/user_model.dart';

class MusicStoreComponent extends StatefulWidget {
  const MusicStoreComponent({super.key});

  @override
  State<MusicStoreComponent> createState() => _MusicStoreComponentState();
}

class _MusicStoreComponentState extends State<MusicStoreComponent> {
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      UserModel user = (authState as LoginState).user;
      return BlocProvider(
        create: (context) => MusicStoreBloc(repository: MusicStoreRepository())
          ..add(MusicStoreGetDataEvent(user: user))
          ..add(MusicStoreGetUserCreatePlaylistEvent(user: user)),
        child: BlocBuilder<MusicStoreBloc, MusicStoreState>(
            builder: (context, musicStoreState) {
          return SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                const MusicStoreHeader(),
                MusicStorePlaylistsComponent(
                  title: '我的歌单',
                  dataSource: musicStoreState.createPlaylists,
                ),
                const CommonFooter()
              ],
            ),
          );
        }),
      );
    });
  }
}
