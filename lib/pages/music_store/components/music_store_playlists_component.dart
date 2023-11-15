import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/music/album_cover.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/utils/size.dart';

class MusicStorePlaylistsComponent extends StatelessWidget {
  final String title;
  final List<PlayListDetailModel> dataSource;
  const MusicStorePlaylistsComponent(
      {super.key, required this.title, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      double screenWidth = SizeUtil.screenWidth(context);
      double itemWidth = SizeUtil.imageSize(context);
      double aspectRatio = (itemWidth + 69) / itemWidth;
      return Container(
        color: themeState.backgroundColor,
        width: SizeUtil.screenWidth(context),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                title,
                style: TextStyle(
                    color: themeState.mainTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
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
                  PlayListDetailModel model = dataSource[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/playlist/detail',
                          arguments: {'title': model.name, 'id': model.id});
                    },
                    child: AlbumCover(
                      id: model.id,
                      name: model.name,
                      coverImageUrl: model.coverImgUrl,
                      artist: model.creator!.nickName,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
