import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/utils/size.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AlbumCover extends StatelessWidget {
  final num id;
  final String name;
  final String coverImageUrl;
  final String? artist;
  const AlbumCover(
      {super.key,
      required this.id,
      required this.name,
      required this.coverImageUrl,
      this.artist});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      double flexSize = SizeUtil.screenWidth(context) / 5 - 15 * 2;
      double imageSize = flexSize > 155 ? flexSize : 155;
      return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: coverImageUrl,
                width: imageSize,
                height: imageSize,
              ),
            ),
            Container(
              width: imageSize,
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                name,
                style: TextStyle(
                    color: state.mainTextColor,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Visibility(
              visible: artist != null,
              child: Container(
                width: imageSize,
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  artist ?? 'error',
                  style: TextStyle(color: state.mainTextColor),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
