import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/music/music_item1.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/music_store/blocs/music_store_bloc.dart';
import 'package:yes_play_music/utils/size.dart';

class MusicStoreLikedList extends StatelessWidget {
  const MusicStoreLikedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<MusicStoreBloc, MusicStoreState>(
          builder: (context, musicStoreState) {
            double width = SizeUtil.screenWidth(context) / 5;
            double height = 40;
            double aspectRatio = height / width;
            return Container(
              width: SizeUtil.screenWidth(context) * 2 / 3 - 70,
              height: SizeUtil.screenWidth(context) / 6,
              padding: const EdgeInsets.all(10),
              color: themeState.backgroundColor,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: aspectRatio,
                    crossAxisSpacing: 10),
                itemCount: musicStoreState.likedSongs.length,
                itemBuilder: (BuildContext context, int index) {
                  SongDetailModel song = musicStoreState.likedSongs[index];
                  return MusicItem1(song: song);
                },
              ),
            );
          },
        );
      },
    );
  }
}
