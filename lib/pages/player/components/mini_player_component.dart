import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/assets/imageCode/flutter_assets.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';

class MiniMuiscPlayerComponent extends StatefulWidget {
  const MiniMuiscPlayerComponent({super.key});

  @override
  State<MiniMuiscPlayerComponent> createState() =>
      _MiniMuiscPlayerComponentState();
}

class _MiniMuiscPlayerComponentState extends State<MiniMuiscPlayerComponent>
    with TickerProviderStateMixin {
  late final AnimationController _rotateController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    //碟片
    _rotateController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _rotateController, curve: Curves.linear);
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (context, musicPlayerState) {
      double imageSize = 40.0;
      if (musicPlayerState.playingStatus == PlayingStatus.paused) {
        _rotateController.stop();
      }
      if (musicPlayerState.playingStatus == PlayingStatus.playing) {
        _rotateController.repeat();
      }
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/player_page');
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: Image(image: AssetImages.cm2DefaultCoverProgram),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(imageSize / 3.4)),
                  width: imageSize / 1.7,
                  height: imageSize / 1.7,
                  child: RotationTransition(
                    turns: _animation,
                    child: CachedNetworkImage(
                        imageUrl: musicPlayerState
                            .currentAudio!.songDetail.album.picUrl),
                  ),
                ),
              ]),
        ),
      );
    });
  }
}
