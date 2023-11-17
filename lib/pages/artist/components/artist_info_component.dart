import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/artist/blocs/artist_bloc.dart';
import 'package:yes_play_music/utils/size.dart';

class ArtistInfoComponent extends StatelessWidget {
  const ArtistInfoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, artistState) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: 150,
                height: 150,
                margin: const EdgeInsets.only(right: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(75)),
                child: CachedNetworkImage(imageUrl: artistState.model!.picUrl),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      artistState.model!.name,
                      style: TextStyle(
                          color: themeState.mainTextColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '${artistState.model!.musicSize}首歌・${artistState.model!.albumSize}张专辑・${artistState.model!.mvSize}个MV',
                    style: TextStyle(
                        color: themeState.secondTextColor, fontSize: 18),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: SizeUtil.screenWidth(context) * 0.75,
                      height: 80,
                      child: SingleChildScrollView(
                          child: Text(
                        artistState.model!.briefDesc,
                        style: TextStyle(color: themeState.secondTextColor),
                      )))
                ],
              )
            ],
          ),
        );
      });
    });
  }
}
