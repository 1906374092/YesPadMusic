import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/assets/imageCode/flutter_assets.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/player/models/audio_model.dart';
import 'package:yes_play_music/utils/tools.dart';

class MusicInfoComponent extends StatelessWidget {
  final AudioModel? audio;
  const MusicInfoComponent({super.key, this.audio});

  @override
  Widget build(BuildContext context) {
    List<String> artists = [];

    if (audio != null) {
      for (ArtistModel element in audio!.songDetail.artists) {
        artists.add(element.name);
      }
    }
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Row(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Image(image: AssetImages.neteaseMusic),
                imageUrl: audio == null
                    ? Tools.placeholderImageUrl()
                    : audio!.songDetail.album.picUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audio != null ? audio!.songDetail.name : '--',
                  style: TextStyle(
                      color: themeState.mainTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  artists.isNotEmpty ? artists.join(',') : '--',
                  style: TextStyle(
                      color: themeState.secondTextColor, fontSize: 15),
                )
              ],
            ),
          )
        ],
      );
    });
  }
}
