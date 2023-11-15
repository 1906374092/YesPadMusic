import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';

class PlayOrderButton extends StatelessWidget {
  final double? size;
  final Color? color;
  PlayOrderButton({super.key, this.size, this.color});
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
              onPressed: () {
                int currentIndex = orders.indexOf(playerState.loopStatus);
                int newIndex =
                    currentIndex == orders.length - 1 ? 0 : currentIndex + 1;
                context.read<MusicPlayerBloc>().add(
                    MusicPlayerChangePlayOrderAction(
                        loopStatus: orders[newIndex]));
              },
              icon: Icon(
                icons[orders.indexOf(playerState.loopStatus)],
                color: color ?? themeState.mainTextColor,
                size: size ?? 30,
              )),
        );
      });
    });
  }
}
