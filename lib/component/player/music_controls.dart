import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';

class FMMusicControls extends StatelessWidget {
  final bool? white;
  final double? size;
  const FMMusicControls({super.key, this.white = true, this.size = 30});

  @override
  Widget build(BuildContext context) {
    Color iconColor = white! ? Colors.white : Colors.black;
    return SizedBox(
      height: size! + 10,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.heart_broken,
                color: iconColor,
                size: size,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow,
                color: iconColor,
                size: size,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.skip_next,
                color: iconColor,
                size: size,
              ))
        ],
      ),
    );
  }
}

class CommonMusicControls extends StatelessWidget {
  final double? size;
  final Color? color;

  const CommonMusicControls({super.key, this.size = 40, this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
          builder: (context, playerState) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  iconSize: size,
                  onPressed: () {
                    context
                        .read<MusicPlayerBloc>()
                        .add(MusicPlayerPlayPreviousAction());
                  },
                  icon: Icon(
                    Icons.skip_previous_rounded,
                    color: color ?? themeState.darkBlueColor,
                  )),
              IconButton(
                  iconSize: size,
                  onPressed: () {
                    if (playerState.playingStatus == PlayingStatus.playing) {
                      context
                          .read<MusicPlayerBloc>()
                          .add(MusicPlayerPauseAction());
                    } else {
                      context
                          .read<MusicPlayerBloc>()
                          .add(MusicPlayerContinueAction());
                    }
                  },
                  icon: Icon(
                    playerState.playingStatus == PlayingStatus.playing
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: color ?? themeState.darkBlueColor,
                  )),
              IconButton(
                  iconSize: size,
                  onPressed: () {
                    context
                        .read<MusicPlayerBloc>()
                        .add(MusicPlayerPlayNextAction());
                  },
                  icon: Icon(
                    Icons.skip_next_rounded,
                    color: color ?? themeState.darkBlueColor,
                  ))
            ],
          ),
        );
      });
    });
  }
}
