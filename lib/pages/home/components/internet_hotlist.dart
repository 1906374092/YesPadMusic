import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme.dart';
import 'package:yes_play_music/component/album_cover.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/pages/home/models/playlist_model.dart';
import 'package:yes_play_music/utils/size.dart';

class SongsList extends StatelessWidget {
  final List<PlayListModel> listData;
  final String listTitle;
  const SongsList({super.key, required this.listData, required this.listTitle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBlock, ThemeState>(
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
              height: SizeUtil.screenWidth(context) / 5 + 55,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                itemCount: listData.length,
                itemBuilder: (BuildContext context, int index) {
                  PlayListModel model = listData[index];
                  return AlbumCover(
                      id: model.id,
                      name: model.name,
                      coverImageUrl: model.coverImgUrl);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
