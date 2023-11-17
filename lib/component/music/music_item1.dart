import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/music/vip_icon.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/utils/size.dart';

class MusicItem1 extends StatelessWidget {
  final SongDetailModel song;
  const MusicItem1({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      double width = SizeUtil.screenWidth(context) / 5;
      double height = 50;
      return GestureDetector(
        onTap: () {
          context
              .read<MusicPlayerBloc>()
              .add(StartPlayMusicAction(songDetail: song));
        },
        child: Container(
          color: Colors.transparent,
          width: width,
          height: height,
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.only(right: 5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: song.album.picUrlMini,
                  placeholder: (context, url) => Container(
                    color: themeState.lightBlueColor,
                  ),
                ),
              ),
              SizedBox(
                height: height,
                width: SizeUtil.screenWidth(context) / 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: themeState.mainTextColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: SizeUtil.screenWidth(context) / 6,
                      child: Row(
                        children: [
                          Visibility(
                              visible: song.fee == 1, child: const VipIcon()),
                          SizedBox(
                            width: SizeUtil.screenWidth(context) / 8,
                            child: Text(
                              ArtistModel.getArtistStrings(song.artists),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: themeState.secondTextColor,
                                  fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
