import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/home/components/header.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/utils/size.dart';

class ArtistToplist extends StatelessWidget {
  final List<ArtistModel> dataSource;
  const ArtistToplist({super.key, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    double flexSize = SizeUtil.screenWidth(context) / 5 - 15 * 2;
    double imageSize = flexSize > 155 ? flexSize : 155;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(
              title: '推荐艺人',
              showAllBtn: false,
            ),
            SizedBox(
              width: SizeUtil.screenWidth(context),
              height: imageSize + 75,
              child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    ArtistModel model = dataSource[index];
                    return Container(
                      padding: const EdgeInsets.all(15),
                      height: 200,
                      child: Column(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: model.picUrl,
                              width: imageSize,
                              height: imageSize,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              model.name,
                              style: TextStyle(
                                  color: themeState.mainTextColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
