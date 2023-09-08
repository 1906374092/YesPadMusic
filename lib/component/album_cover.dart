import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme.dart';
import 'package:yes_play_music/utils/size.dart';

class AlbumCover extends StatelessWidget {
  final num id;
  final String name;
  final String coverImageUrl;
  const AlbumCover(
      {super.key,
      required this.id,
      required this.name,
      required this.coverImageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBlock, ThemeState>(builder: (context, state) {
      double flexSize = SizeUtil.screenWidth(context) / 5 - 15 * 2;
      double imageSize = flexSize > 155 ? flexSize : 155;
      return Container(
        padding: const EdgeInsets.all(15),
        width: imageSize + 30,
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Image(
                image: NetworkImage(coverImageUrl),
                width: imageSize,
                height: imageSize,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                name,
                style: TextStyle(color: state.mainTextColor),
              ),
            )
          ],
        ),
      );
    });
  }
}
