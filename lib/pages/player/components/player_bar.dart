import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/component/player/music_controls.dart';
import 'package:yes_play_music/component/player/music_list_button.dart';
import 'package:yes_play_music/component/player/play_order_button.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/player/components/mini_music_info_component.dart.dart';
import 'package:yes_play_music/utils/size.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    double sidePadding = SizeUtil.screenWidth(context) / 25;
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
          builder: (context, musicPlayerState) {
        double bottom = 0;

        if (musicPlayerState is PlayerStopState) {
          bottom = -80;
        } else {
          bottom = 0;
        }
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.ease,
          bottom: bottom,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/player_page');
            },
            child: Container(
              width: SizeUtil.screenWidth(context),
              height: 80,
              color: (themeState.backgroundColor as Color).withOpacity(0.8),
              child: ClipRRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: sidePadding,
                      right: sidePadding,
                      top: 10,
                      bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MiniMusicInfoComponent(
                          audio: musicPlayerState.currentAudio),
                      const Spacer(),
                      const CommonMusicControls(),
                      const Spacer(),
                      SizedBox(
                        width: SizeUtil.screenWidth(context) / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const MusicListButton(),
                            PlayOrderButton()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          ),
        );
      });
    });
  }
}
