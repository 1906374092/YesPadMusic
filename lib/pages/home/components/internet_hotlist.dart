import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/music/album_cover.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/utils/size.dart';

class SongsList extends StatelessWidget {
  final List<PlayListDetailModel> listData;
  final String listTitle;
  const SongsList({super.key, required this.listData, required this.listTitle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              title: listTitle,
              showAllBtn: false,
            ),
            SizedBox(
              width: SizeUtil.screenWidth(context),
              height: SizeUtil.imageSize(context) + 70,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  PlayListDetailModel model = listData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/playlist/detail',
                          arguments: {'title': model.name, 'id': model.id});
                    },
                    child: AlbumCover(
                        id: model.id,
                        name: model.name,
                        coverImageUrl: model.coverImgUrl),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
