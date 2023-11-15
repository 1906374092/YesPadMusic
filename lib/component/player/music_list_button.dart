import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';

class MusicListButton extends StatelessWidget {
  final double? size;
  final Color? color;
  const MusicListButton({super.key, this.size = 30, this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Container(
        child: IconButton(
            iconSize: size,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(
              Icons.queue_music_rounded,
              color: color ?? themeState.mainTextColor,
            )),
      );
    });
  }
}
