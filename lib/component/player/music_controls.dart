import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';

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
  final PlayerState playerState;

  const CommonMusicControls(
      {super.key, this.size = 40, required this.playerState});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Container(
        child: Row(
          children: [
            IconButton(
                iconSize: size,
                onPressed: () {},
                icon: Icon(
                  Icons.skip_previous_rounded,
                  color: themeState.mainTextColor,
                )),
            IconButton(
                iconSize: size,
                onPressed: () {},
                icon: Icon(
                  playerState == PlayerState.playing
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: themeState.mainTextColor,
                )),
            IconButton(
                iconSize: size,
                onPressed: () {},
                icon: Icon(
                  Icons.skip_next_rounded,
                  color: themeState.mainTextColor,
                ))
          ],
        ),
      );
    });
  }
}
