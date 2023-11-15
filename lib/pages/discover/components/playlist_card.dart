import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/discover/blocs/discover_bloc.dart';
import 'package:yes_play_music/pages/discover/components/category_playlists.dart';
import 'package:yes_play_music/pages/discover/models/category_model.dart';
import 'package:yes_play_music/utils/size.dart';

class PlayListCard extends StatelessWidget {
  final int index;
  const PlayListCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<DiscoverBloc, DiscoverState>(
          builder: (context, discoverState) {
        CategoryModel model = discoverState.categories[index];
        return Card(
          color: themeState.backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                model.name,
                style: TextStyle(
                    color: themeState.secondTextColor,
                    fontSize: SizeUtil.screenWidth(context) / 6,
                    fontFamily: 'zhentan'),
              ),
              CategoryPlaylistsComponent(category: model.name)
            ],
          ),
        );
      });
    });
  }
}
