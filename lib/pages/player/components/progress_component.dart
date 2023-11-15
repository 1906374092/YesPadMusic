import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/utils/colorutil.dart';
import 'package:yes_play_music/utils/size.dart';
import 'package:yes_play_music/utils/tools.dart';

class ProgressComponent extends StatelessWidget {
  final double? width;
  final Color? valueColor;
  final Color? backgroundColor;
  final bool? showTimeLabel;
  const ProgressComponent(
      {super.key,
      this.width,
      this.valueColor,
      this.backgroundColor,
      this.showTimeLabel = true});
  @override
  Widget build(BuildContext context) {
    double size = width ?? SizeUtil.screenWidth(context) / 3;
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (context, musicPlayerState) {
      int currentMillSecond = musicPlayerState.progress == null
          ? 0
          : musicPlayerState.progress!.inMilliseconds;
      num totalMillSeconds = musicPlayerState.currentAudio!.time;
      return Container(
        width: size,
        margin: const EdgeInsets.only(top: 25, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: showTimeLabel!,
              child: Text(
                Tools.timeStringFromNum(currentMillSecond),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Container(
              width: size - 120,
              margin: const EdgeInsets.only(right: 10, left: 10),
              child: LinearProgressIndicator(
                value: currentMillSecond / totalMillSeconds,
                valueColor:
                    AlwaysStoppedAnimation<Color>(valueColor ?? Colors.white),
                backgroundColor: backgroundColor ?? ColorUtil.commonLightGrey,
              ),
            ),
            Visibility(
              visible: showTimeLabel!,
              child: Text(
                Tools.timeStringFromNum(musicPlayerState.currentAudio!.time),
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    });
  }
}
