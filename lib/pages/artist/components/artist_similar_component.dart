import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/artist/blocs/artist_bloc.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/utils/size.dart';

class SimilarArtistsComponent extends StatelessWidget {
  const SimilarArtistsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, artistState) {
        double screenWidth = SizeUtil.screenWidth(context);
        double itemWidth = SizeUtil.imageSize(context);
        double aspectRatio = itemWidth / (itemWidth + 80);
        return Column(
          children: [
            Header(
              title: '相似艺人',
              showAllBtn: false,
              titleStyle: TextStyle(
                  color: themeState.mainTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: screenWidth,
              height: (SizeUtil.imageSize(context) + 120) * 4,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, childAspectRatio: aspectRatio),
                itemCount: artistState.similarArtists.length,
                itemBuilder: (BuildContext context, int index) {
                  ArtistModel model = artistState.similarArtists[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/artist_detail',
                          arguments: {'id': model.id, 'name': model.name});
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ClipOval(
                              child:
                                  CachedNetworkImage(imageUrl: model.picUrl)),
                        ),
                        Text(
                          model.name,
                          style: TextStyle(
                              color: themeState.mainTextColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      });
    });
  }
}
