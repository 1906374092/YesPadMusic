import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/component/appbar.dart';
import 'package:yes_play_music/component/music/vip_icon.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/local_playlist/components/local_playlist.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/pages/player/components/lyrics_component.dart';
import 'package:yes_play_music/pages/player/components/music_cover_component.dart';
import 'package:yes_play_music/utils/colorutil.dart';
import 'package:yes_play_music/utils/size.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (context, musicPlayerState) {
      return Scaffold(
        endDrawer: const LocalPlaylist(),
        extendBodyBehindAppBar: true,
        appBar: CommonAppBar(
          actions: [Container()],
          title: musicPlayerState.currentAudio!.songDetail.name,
          titleWidget: Column(
            children: [
              Text(
                musicPlayerState.currentAudio!.songDetail.name,
                style: const TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible:
                          musicPlayerState.currentAudio!.songDetail.fee == 1,
                      child: const VipIcon()),
                  GestureDetector(
                    child: Text(
                      ArtistModel.getArtistStrings(
                          musicPlayerState.currentAudio!.songDetail.artists),
                      style: TextStyle(
                          fontSize: 14, color: ColorUtil.fromHex('#efefef')),
                    ),
                  ),
                ],
              )
            ],
          ),
          titleColor: Colors.white,
          backgroundColor: Colors.transparent,
          leftBtn: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
                size: 40,
              )),
        ),
        body: Container(
            width: SizeUtil.screenWidth(context),
            height: SizeUtil.screenHeight(context),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                image: DecorationImage(
                    opacity: 0.6,
                    scale: 0.1,
                    fit: BoxFit.none,
                    image: NetworkImage(musicPlayerState
                        .currentAudio!.songDetail.album.picUrl))),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MusicCoverComponent(),
                    LyricsComponent(
                      song: musicPlayerState.currentAudio!.songDetail,
                    )
                  ],
                ),
              ),
            )),
      );
    });
  }
}
