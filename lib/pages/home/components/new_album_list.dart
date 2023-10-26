import 'package:flutter/material.dart';
import 'package:yes_play_music/component/music/album_cover.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/pages/home/models/album_model.dart';
import 'package:yes_play_music/utils/size.dart';

class NewAlbumList extends StatelessWidget {
  final List<AlbumModel> dataSource;
  const NewAlbumList({super.key, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    double screenWidth = SizeUtil.screenWidth(context);
    double itemWidth = SizeUtil.imageSize(context);
    double aspectRatio = (itemWidth + 69) / itemWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title: '新专速递'),
        SizedBox(
          width: screenWidth,
          height: (SizeUtil.imageSize(context) + 110) * 2,
          child: GridView.builder(
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: aspectRatio),
            itemCount: dataSource.length,
            itemBuilder: (BuildContext context, int index) {
              AlbumModel model = dataSource[index];
              return AlbumCover(
                id: model.id,
                name: model.name,
                coverImageUrl: model.picUrl,
                artist: model.artist!.name,
              );
            },
          ),
        ),
      ],
    );
  }
}
