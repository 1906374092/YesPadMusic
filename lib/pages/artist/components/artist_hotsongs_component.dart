import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/music/music_item1.dart';
import 'package:yes_play_music/pages/artist/blocs/artist_bloc.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/utils/size.dart';

class ArtistHotSongsComponent extends StatelessWidget {
  const ArtistHotSongsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    double width = SizeUtil.screenWidth(context) / 5;
    double height = 40;
    double aspectRatio = height / width;
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, artistState) {
        if (artistState.model == null) {
          return Container();
        }
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '热门歌曲',
                style: TextStyle(
                    color: themeState.mainTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: SizeUtil.screenWidth(context) - 40,
                height: 280,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: aspectRatio,
                      crossAxisSpacing: 10),
                  itemCount: artistState.model!.hotSongs.length,
                  itemBuilder: (BuildContext context, int index) {
                    SongDetailModel song = artistState.model!.hotSongs[index];
                    return MusicItem1(song: song);
                  },
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}
