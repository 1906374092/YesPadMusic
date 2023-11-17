import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/appbar.dart';
import 'package:yes_play_music/pages/artist/blocs/artist_bloc.dart';
import 'package:yes_play_music/pages/artist/components/artist_album_component.dart';
import 'package:yes_play_music/pages/artist/components/artist_detail_shimmer.dart';
import 'package:yes_play_music/pages/artist/components/artist_hotsongs_component.dart';
import 'package:yes_play_music/pages/artist/components/artist_info_component.dart';
import 'package:yes_play_music/pages/artist/components/artist_similar_component.dart';
import 'package:yes_play_music/pages/artist/data/artist_repository.dart';
import 'package:yes_play_music/pages/player/components/mini_player_component.dart';
import 'package:yes_play_music/utils/global.dart';

class ArtistPage extends StatefulWidget {
  final num id;
  final String name;
  const ArtistPage({super.key, required this.id, required this.name});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  final ScrollController _controller = ScrollController();
  String _title = '艺人';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.offset > 92) {
        setState(() {
          _title = widget.name;
        });
      } else {
        setState(() {
          _title = '艺人';
        });
      }
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
      create: (context) => ArtistBloc(repository: ArtistRepository())
        ..add(ArtistGetDataEvent(id: widget.id))
        ..add(ArtistGetHotAlbumsEvent(id: widget.id))
        ..add(ArtistGetSimilarArtistsEvent(id: widget.id)),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return Scaffold(
            appBar: CommonAppBar(
              title: _title,
              backgroundColor: themeState.backgroundColor,
              actions: const [MiniMuiscPlayerComponent()],
            ),
            body: BlocBuilder<ArtistBloc, ArtistState>(
                builder: (context, artistState) {
              if (artistState.model == null) {
                return const ArtistDetailShimmer();
              }
              return SingleChildScrollView(
                  controller: _controller,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: themeState.backgroundColor,
                    child: const Column(
                      children: [
                        ArtistInfoComponent(),
                        ArtistHotSongsComponent(),
                        ArtistAlbumComponent(),
                        SimilarArtistsComponent()
                      ],
                    ),
                  ));
            }));
      }),
    );
  }
}
