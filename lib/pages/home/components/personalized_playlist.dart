import 'package:flutter/material.dart';
import 'package:yes_play_music/component/music/album_cover.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/pages/playlist_all/components/playlist_all.dart';
import 'package:yes_play_music/utils/size.dart';

class PersonalizedPlaylist extends StatelessWidget {
  final String listTitle;
  final List<PlayListDetailModel> dataSorce;
  const PersonalizedPlaylist(
      {super.key, required this.listTitle, required this.dataSorce});

  @override
  Widget build(BuildContext context) {
    double screenWidth = SizeUtil.screenWidth(context);
    double itemWidth = SizeUtil.imageSize(context);
    double aspectRatio = (itemWidth + 35) / itemWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(
          title: listTitle,
          action: () {
            Navigator.of(context).pushNamed('/playlist_all',
                arguments: {'type': PlaylistType.recommend, 'category': null});
          },
        ),
        SizedBox(
          width: screenWidth,
          height: (SizeUtil.imageSize(context) + 70) * 2,
          child: GridView.builder(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: aspectRatio,
            ),
            itemCount: dataSorce.length,
            itemBuilder: (BuildContext context, int index) {
              PlayListDetailModel model = dataSorce[index];
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
  }
}
