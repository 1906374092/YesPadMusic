import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme.dart';
import 'package:yes_play_music/component/album_cover.dart';
import 'package:yes_play_music/component/loading.dart';
import 'package:yes_play_music/pages/home/blocs/home_bloc.dart';
import 'package:yes_play_music/pages/home/data/home_repository.dart';
import 'package:yes_play_music/pages/home/models/playlist_model.dart';
import 'package:yes_play_music/utils/size.dart';

class HomePage extends StatelessWidget {
  final HomeRepository repository;
  const HomePage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (context) =>
            HomeBloc(repository: repository)..add(OnGetDataEvent()),
        child: BlocBuilder<ThemeBlock, ThemeState>(
          builder: (context, state) {
            return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              if (state is ErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is SuccessState) {
                return SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 15),
                    child: BlocBuilder<ThemeBlock, ThemeState>(
                      builder: (context, themeState) {
                        return Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    '网友精选碟',
                                    style: TextStyle(
                                        color: themeState.mainTextColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeUtil.screenWidth(context),
                                  height: 300,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(0),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.hotPlaylistData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      PlayListModel model =
                                          state.hotPlaylistData[index];
                                      return AlbumCover(
                                          id: model.id,
                                          name: model.name,
                                          coverImageUrl: model.coverImgUrl);
                                    },
                                  ),
                                ),
                              ],
                            )
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
