import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';

class PlayOrderButton extends StatelessWidget {
  PlayOrderButton({super.key});
  final List<LoopStatus> orders = [
    LoopStatus.sequence,
    LoopStatus.random,
    LoopStatus.single
  ];
  final List<IconData> icons = [
    Icons.loop_rounded,
    Icons.shuffle_rounded,
    Icons.repeat_one_rounded
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
          builder: (context, playerState) {
        return Container(
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                icons[orders.indexOf(playerState.loopStatus)],
                color: themeState.mainTextColor,
              )),
        );
      });
    });
  }
}
