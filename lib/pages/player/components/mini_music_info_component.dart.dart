import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/assets/imageCode/flutter_assets.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/music/vip_icon.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/player/models/audio_model.dart';
import 'package:yes_play_music/utils/size.dart';
import 'package:yes_play_music/utils/tools.dart';

class MiniMusicInfoComponent extends StatelessWidget {
  final AudioModel? audio;
  const MiniMusicInfoComponent({super.key, this.audio});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return SizedBox(
        width: SizeUtil.screenWidth(context) / 3.5,
        child: Row(
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
                      : audio!.songDetail.album.picUrlMini),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: SizeUtil.screenWidth(context) / 6,
                    child: Text(
                      audio != null ? audio!.songDetail.name : '--',
                      style: TextStyle(
                          color: themeState.mainTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Visibility(
                          visible: audio != null
                              ? audio!.songDetail.fee == 1
                              : false,
                          child: const VipIcon()),
                      SizedBox(
                        width: SizeUtil.screenWidth(context) / 6,
                        child: Text(
                          audio == null
                              ? '--'
                              : ArtistModel.getArtistStrings(
                                  audio!.songDetail.artists),
                          style: TextStyle(
                              color: themeState.secondTextColor, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
