import 'package:flutter/material.dart';
import 'package:yes_play_music/component/album_cover.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/pages/home/models/playlist_model.dart';
import 'package:yes_play_music/utils/size.dart';

class PersonalizedPlaylist extends StatelessWidget {
  final String listTitle;
  final List<PlayListModel> dataSorce;
  const PersonalizedPlaylist(
      {super.key, required this.listTitle, required this.dataSorce});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(title: listTitle),
        SizedBox(
          width: SizeUtil.screenWidth(context),
          height: (SizeUtil.screenWidth(context) / 5 + 55) * 2,
          child: GridView.builder(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.29),
            itemCount: dataSorce.length,
            itemBuilder: (BuildContext context, int index) {
              PlayListModel model = dataSorce[index];
              return AlbumCover(
                  id: model.id,
                  name: model.name,
                  coverImageUrl: model.coverImgUrl);
            },
          ),
        ),
      ],
    );
  }
}
