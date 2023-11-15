import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/local_playlist/blocs/local_playlist_bloc.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/utils/size.dart';

class LocalPlaylist extends StatelessWidget {
  const LocalPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocProvider(
          create: (context) =>
              LocalPlaylistBloc()..add(PlaylistGetLocalDataEvent()),
          child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
            return BlocBuilder<LocalPlaylistBloc, LocalPlaylistState>(
                builder: (context, playListState) {
              return Container(
                color: themeState.backgroundColor,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 50),
                  itemCount: playListState.songList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    SongDetailModel song = playListState.songList[index];
                    int currentIndex =
                        playListState.songList.indexOf(playListState.current);
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<MusicPlayerBloc>()
                            .add(StartPlayMusicAction(songDetail: song));
                        context
                            .read<LocalPlaylistBloc>()
                            .add(PlaylistGetLocalDataEvent());
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        color: themeState.backgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeUtil.screenWidth(context) / 4.5,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: song.name,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: currentIndex == index
                                              ? themeState.darkBlueColor
                                              : themeState.mainTextColor)),
                                  TextSpan(
                                      text:
                                          '・${ArtistModel.getArtistStrings(song.artists)}',
                                      style: TextStyle(
                                          color: currentIndex == index
                                              ? themeState.darkBlueColor
                                              : themeState.secondTextColor))
                                ]),
                              ),
                            ),
                            const Spacer(),
                            Visibility(
                              visible: currentIndex != index,
                              child: MaterialButton(
                                minWidth: 20,
                                onPressed: () {
                                  context
                                      .read<LocalPlaylistBloc>()
                                      .add(PlaylistDeleteItemEvent(song: song));
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  color: themeState.secondTextColor,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            });
          })),
    );
  }
}
