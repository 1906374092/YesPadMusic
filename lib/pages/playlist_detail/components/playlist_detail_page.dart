import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/component/appbar.dart';
import 'package:yes_play_music/pages/player/components/mini_player_component.dart';
import 'package:yes_play_music/pages/playlist_detail/blocs/playlist_detail_bloc.dart';
import 'package:yes_play_music/pages/playlist_detail/components/playlist_detail_songs.dart';
import 'package:yes_play_music/pages/playlist_detail/data/playlist_detail_repository.dart';
import 'package:yes_play_music/utils/colorutil.dart';
import 'package:yes_play_music/utils/size.dart';

class PlaylistDetailPage extends StatefulWidget {
  final String name;
  final num id;
  const PlaylistDetailPage({super.key, required this.name, required this.id});
  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  final ScrollController _controller = ScrollController();
  final Color _firstColor = ColorUtil.getRandomColor();
  final Color _secondColor = ColorUtil.getRandomColor();
  double _topBarOpacity = 0.0;

  String _title = '歌单';
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset > 64) {
        setState(() {
          _title = widget.name;
        });
      } else {
        setState(() {
          _title = '歌单';
        });
      }
      setState(() {
        if (_controller.offset > 64.0) {
          _topBarOpacity = 1.0;
        } else {
          _topBarOpacity =
              _controller.offset < 0 ? 0.0 : _controller.offset / 64.0;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PlaylistDetailBloc(repository: PlaylistDetailRepository())
            ..add(PlaylistDetailGetDataEvent(id: widget.id)),
      child: Builder(builder: (context) {
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CommonAppBar(
              title: _title,
              titleColor: Colors.white,
              leftBtnColor: Colors.white,
              backgroundColor: _firstColor.withOpacity(_topBarOpacity),
              actions: const [MiniMuiscPlayerComponent()],
            ),
            body: BlocBuilder<PlaylistDetailBloc, PlaylistDetailState>(
                builder: (context, detailState) {
              return Container(
                padding: EdgeInsets.only(top: SizeUtil.topBarHeight(context)),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [_firstColor, _secondColor])),
                child: PlaylistDetailSongsComponent(
                  id: widget.id,
                  controller: _controller,
                  refreshBg: _firstColor,
                  loadBg: _secondColor,
                ),
              );
            }));
      }),
    );
  }
}
