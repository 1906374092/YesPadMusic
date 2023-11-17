import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/appbar.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/player/components/mini_player_component.dart';
import 'package:yes_play_music/pages/playlist_all/blocs/playlist_all_bloc.dart';
import 'package:yes_play_music/pages/playlist_all/components/playlist_tile1.dart';
import 'package:yes_play_music/pages/playlist_all/data/playlist_all_repository.dart';

enum PlaylistType { recommend, category }

class PlaylistAllPage extends StatelessWidget {
  final PlaylistType? type;
  final String? category;
  const PlaylistAllPage(
      {super.key, this.type = PlaylistType.recommend, this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaylistAllBloc(repository: PlaylistAllRepository()),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return BlocBuilder<PlaylistAllBloc, PlaylistAllState>(
            builder: (context, playlistAllState) {
          return Scaffold(
            appBar: CommonAppBar(
              title: category ?? '推荐歌单',
              actions: const [MiniMuiscPlayerComponent()],
            ),
            body: EasyRefresh.builder(
                refreshOnStart: true,
                onRefresh: () {
                  context
                      .read<PlaylistAllBloc>()
                      .add(PlaylistAllGetDataEvent(category: category));
                },
                childBuilder: (context, physics) {
                  return Container(
                    color: themeState.backgroundColor,
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.custom(
                      physics: physics,
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: [
                          const QuiltedGridTile(2, 2),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                          const QuiltedGridTile(1, 1),
                        ],
                      ),
                      childrenDelegate:
                          SliverChildBuilderDelegate((context, index) {
                        PlayListDetailModel model =
                            playlistAllState.models[index];
                        return PlaylistTile1Component(
                          model: model,
                        );
                      }, childCount: playlistAllState.models.length),
                    ),
                  );
                }),
          );
        });
      }),
    );
  }
}
