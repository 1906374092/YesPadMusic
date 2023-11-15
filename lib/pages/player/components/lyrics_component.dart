import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/player/blocs/lyric_bloc.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/pages/player/models/lyric_model.dart';
import 'package:yes_play_music/utils/size.dart';

class LyricsComponent extends StatefulWidget {
  final SongDetailModel song;
  const LyricsComponent({super.key, required this.song});

  @override
  State<LyricsComponent> createState() => _LyricsComponentState();
}

class _LyricsComponentState extends State<LyricsComponent> {
  late final ScrollController _controller;
  final double _itemHeight = 35.0;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widgetWidth = SizeUtil.screenWidth(context) / 2 - 50;
    double padding = (SizeUtil.screenHeight(context) - 200) / 2;
    return BlocProvider(
      create: (context) =>
          LyricBloc(repository: context.read<MusicPlayerBloc>().repository)
            ..add(LyricGetDataEvent(song: widget.song)),
      child: BlocBuilder<LyricBloc, LyricState>(buildWhen: (previous, current) {
        _controller.animateTo(current.currentIndex * _itemHeight,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
        return previous.currentIndex != current.currentIndex;
      }, builder: (context, lyricState) {
        return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
            buildWhen: (previous, current) {
          if (previous.currentAudio!.songDetail !=
              current.currentAudio!.songDetail) {
            context
                .read<LyricBloc>()
                .add(LyricGetDataEvent(song: current.currentAudio!.songDetail));
          }
          return true;
        }, builder: (context, musicPlayerState) {
          return Container(
            width: widgetWidth,
            height: SizeUtil.screenHeight(context) - 200,
            padding: const EdgeInsets.only(top: 30),
            child: ListView.builder(
              itemCount: lyricState.lyrics.length,
              itemExtent: _itemHeight,
              controller: _controller,
              padding: EdgeInsets.only(top: padding, bottom: padding),
              itemBuilder: (context, index) {
                LyricModel model = lyricState.lyrics[index];
                return Center(
                    child: Text(
                  model.lyric,
                  style: TextStyle(
                      color: index == lyricState.currentIndex
                          ? Colors.white
                          : Colors.white.withOpacity(0.6),
                      fontSize: index == lyricState.currentIndex ? 20 : 18,
                      fontWeight: index == lyricState.currentIndex
                          ? FontWeight.bold
                          : FontWeight.normal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ));
              },
            ),
          );
        });
      }),
    );
  }
}
