import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yes_play_music/component/player/play_button.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/pages/home/components/personal_fm.dart';
import 'package:yes_play_music/pages/home/models/playlist_model.dart';
import 'package:yes_play_music/pages/home/models/song_model.dart';
import 'package:yes_play_music/utils/size.dart';

class ForYouWidget extends StatefulWidget {
  final List<PlayListModel> dataSource;
  final List<SongModel> fmData;
  const ForYouWidget(
      {super.key, required this.dataSource, required this.fmData});
  @override
  State<ForYouWidget> createState() => _ForYouWidgetState();
}

class _ForYouWidgetState extends State<ForYouWidget> {
  final ScrollController _controller = ScrollController();
  late double imageWidth = 0.0;
  double imageHeight = 150.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.animateTo(imageWidth - imageHeight,
          duration: const Duration(seconds: 15), curve: Curves.linear);
    });
    _controller.addListener(() {
      if (_controller.offset <= 10) {
        _controller.animateTo(imageWidth - imageHeight,
            duration: const Duration(seconds: 15), curve: Curves.linear);
      }
      if (_controller.offset >= imageWidth - imageHeight - 10) {
        _controller.animateTo(0.0,
            duration: const Duration(seconds: 15), curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PlayListModel model =
        widget.dataSource[Random().nextInt(widget.dataSource.length)];
    imageWidth = SizeUtil.screenWidth(context) / 2 - 30;
    return Container(
      width: SizeUtil.screenWidth(context),
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: 'For You',
            showAllBtn: false,
          ),
          Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    width: imageWidth,
                    height: imageHeight,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _controller,
                      child: SizedBox(
                        width: imageWidth,
                        height: imageWidth,
                        child: CachedNetworkImage(
                          imageUrl: model.coverImgUrl,
                          width: imageWidth,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      width: imageWidth,
                      height: imageHeight,
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Text('每日推荐',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Spacer(),
                          BlurPlayButton(size: 50)
                        ],
                      )),
                ],
              ),
              const Spacer(),
              Container(
                  width: imageWidth,
                  height: imageHeight,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  clipBehavior: Clip.hardEdge,
                  child: PersonalFM(dataSource: widget.fmData))
            ],
          )
        ],
      ),
    );
  }
}
