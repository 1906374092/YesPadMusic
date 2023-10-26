import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';

class MusicListButton extends StatelessWidget {
  final double? size;
  const MusicListButton({super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Container(
        child: IconButton(
            iconSize: size,
            onPressed: () {},
            icon: Icon(
              Icons.queue_music_rounded,
              color: themeState.mainTextColor,
            )),
      );
    });
  }
}
