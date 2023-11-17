import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/music/album_cover.dart';
import 'package:yes_play_music/pages/artist/blocs/artist_bloc.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/utils/size.dart';

class ArtistAlbumComponent extends StatelessWidget {
  const ArtistAlbumComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, artistState) {
            double screenWidth = SizeUtil.screenWidth(context);
            double itemWidth = SizeUtil.imageSize(context);
            double aspectRatio = (itemWidth + 70) / itemWidth;
            return Column(
              children: [
                Header(
                  title: '热门专辑',
                  titleStyle: TextStyle(
                      color: themeState.mainTextColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  showAllBtn: true,
                  action: () {},
                ),
                SizedBox(
                  width: screenWidth,
                  height: (SizeUtil.imageSize(context) + 100) * 2,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: aspectRatio),
                    itemCount: artistState.albums.length,
                    itemBuilder: (BuildContext context, int index) {
                      AlbumModel model = artistState.albums[index];
                      return GestureDetector(
                        onTap: () {},
                        child: AlbumCover(
                            id: model.id,
                            name: model.name,
                            coverImageUrl: model.picUrl),
                      );
                    },
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
