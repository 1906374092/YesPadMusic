import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBlock, ThemeState>(builder: (context, themeState) {
      return Container(
        width: View.of(context).physicalSize.width,
        height: 80,
        color: (themeState.backgroundColor as Color).withOpacity(0.6),
        child: ClipRRect(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Text('hello'),
        )),
      );
    });
  }
}
