import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme.dart';
import 'package:yes_play_music/component/footer.dart';
import 'package:yes_play_music/component/loading.dart';
import 'package:yes_play_music/pages/home/blocs/home_bloc.dart';
import 'package:yes_play_music/pages/home/components/artist_toplist.dart';
import 'package:yes_play_music/pages/home/components/for_you.dart';
import 'package:yes_play_music/pages/home/components/internet_hotlist.dart';
import 'package:yes_play_music/pages/home/components/new_album_list.dart';
import 'package:yes_play_music/pages/home/components/personalized_playlist.dart';
import 'package:yes_play_music/pages/home/data/home_repository.dart';

class HomePage extends StatelessWidget {
  final HomeRepository repository;
  const HomePage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (context) =>
            HomeBloc(repository: repository)..add(OnGetDataEvent()),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is ErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is SuccessState) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 15),
                    child: BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, themeState) {
                        return Column(
                          children: [
                            SongsList(
                                listData: state.hotPlaylistData,
                                listTitle: '网友精选碟'),
                            PersonalizedPlaylist(
                                listTitle: '推荐歌单',
                                dataSorce: state.personalizedPlaylistData),
                            ForYouWidget(
                              dataSource: state.personalizedPlaylistData,
                              fmData: state.personalFMData,
                            ),
                            ArtistToplist(dataSource: state.artistListData),
                            NewAlbumList(dataSource: state.newAlbumListData),
                            SongsList(
                                listData: state.topListData, listTitle: '排行榜'),
                            const Footer()
                          ],
                        );
                      },
                    ));
              } else {
                return const Center(
                  child: Loading(),
                );
              }
            });
          },
        ));
  }
}
