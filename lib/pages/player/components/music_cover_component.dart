import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/assets/imageCode/flutter_assets.dart';
import 'package:yes_play_music/component/player/music_controls.dart';
import 'package:yes_play_music/component/player/music_list_button.dart';
import 'package:yes_play_music/component/player/play_order_button.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/pages/player/components/progress_component.dart';
import 'package:yes_play_music/utils/size.dart';

class MusicCoverComponent extends StatefulWidget {
  const MusicCoverComponent({super.key});

  @override
  State<MusicCoverComponent> createState() => _MusicCoverComponentState();
}

class _MusicCoverComponentState extends State<MusicCoverComponent>
    with TickerProviderStateMixin {
  late final AnimationController _rotateController;
  late final AnimationController _needleController;
  late final Animation<double> _animation;
  late final Animation<double> _needleAnimation;
  double needleAngle = 0.0;
  @override
  void initState() {
    super.initState();
    //碟片
    _rotateController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    _animation =
        CurvedAnimation(parent: _rotateController, curve: Curves.linear);
    //机械臂
    _needleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _needleAnimation =
        Tween<double>(begin: 0, end: -0.35).animate(_needleController)
          ..addListener(() {
            setState(() {
              needleAngle = _needleAnimation.value;
            });
          });
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _needleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widgetWidth = SizeUtil.screenWidth(context) / 2 - 50;
    double imageSize = SizeUtil.screenWidth(context) / 3.5;
    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, musicPlayerState) {
        if (musicPlayerState.playingStatus == PlayingStatus.paused) {
          _rotateController.stop();
          _needleController.forward();
        }
        if (musicPlayerState.playingStatus == PlayingStatus.playing) {
          _rotateController.repeat();
          _needleController.reverse();
        }
        return Container(
          width: widgetWidth,
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
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
                  Positioned(
                    top: -imageSize / 2.5,
                    child: SizedBox(
                        width: imageSize / 1.5,
                        height: imageSize / 1.5,
                        child: Transform.rotate(
                          origin: Offset(-40, -imageSize / 3 + 10),
                          angle: needleAngle,
                          child: const Image(
                            image: AssetImage(Assets.cm2PlayNeedlePlay),
                          ),
                        )),
                  )
                ],
              ),
              const ProgressComponent(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CommonMusicControls(
                    size: 50,
                    color: Colors.white,
                  ),
                  const MusicListButton(
                    size: 40,
                    color: Colors.white,
                  ),
                  PlayOrderButton(
                    size: 35,
                    color: Colors.white,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
