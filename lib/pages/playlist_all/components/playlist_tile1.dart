import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';

class PlaylistTile1Component extends StatelessWidget {
  final PlayListDetailModel model;
  const PlaylistTile1Component({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraits) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/playlist/detail',
              arguments: {'title': model.name, 'id': model.id});
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: constraits.maxWidth,
              height: constraits.maxHeight,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: model.coverImgUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                model.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    });
  }
}
