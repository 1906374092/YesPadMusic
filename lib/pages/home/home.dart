import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/footer.dart';
import 'package:yes_play_music/component/loading.dart';
import 'package:yes_play_music/pages/home/blocs/home_bloc.dart';
import 'package:yes_play_music/pages/home/components/artist_toplist.dart';
import 'package:yes_play_music/pages/home/components/for_you.dart';
import 'package:yes_play_music/pages/home/components/internet_hotlist.dart';
import 'package:yes_play_music/pages/home/components/new_album_list.dart';
import 'package:yes_play_music/pages/home/components/personalized_playlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        EasyRefresh.defaultHeaderBuilder = () => BezierCircleHeader(
            triggerOffset: 50,
            hapticFeedback: true,
            foregroundColor: themeState.mainTextColor,
            backgroundColor: themeState.backgroundColor);
        EasyRefresh.defaultFooterBuilder = () => BezierFooter(
            hapticFeedback: true,
            backgroundColor: themeState.backgroundColor,
            triggerOffset: 50);
        return BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is ErrorState) {
                return SingleChildScrollView(
                  child: Center(
                    child: Text(state.errorMessage),
                  ),
                );
              } else if (state is SuccessState) {
                return EasyRefresh.builder(onRefresh: () {
                  context.read<HomeBloc>().add(OnGetDataEvent());
                }, childBuilder: (context, physics) {
                  return SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 15),
                      physics: physics,
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
                                  listData: state.topListData,
                                  listTitle: '排行榜'),
                              const CommonFooter()
                            ],
                          );
                        },
                      ));
                });
              } else {
                return const Center(
                  child: Loading(),
                );
              }
            });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
