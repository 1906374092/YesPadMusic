import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yes_play_music/component/player/music_controls.dart';
import 'package:yes_play_music/pages/home/models/song_model.dart';
import 'package:yes_play_music/utils/colorutil.dart';
import 'package:yes_play_music/utils/size.dart';

class PersonalFM extends StatelessWidget {
  final List<SongModel> dataSource;
  const PersonalFM({super.key, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            ColorUtil.getRandomColor(),
            ColorUtil.getRandomColor()
          ])),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: dataSource[0].album.picUrl,
              width: 120,
              height: 120,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 0.28 * SizeUtil.screenWidth(context),
                  height: 30,
                  child: Text(
                    dataSource[0].name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    dataSource[0].artists[0].name,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 0.28 * SizeUtil.screenWidth(context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const MusicControls(),
                      const Spacer(),
                      Icon(
                        Icons.radio,
                        color: Colors.white.withOpacity(0.5),
                        size: 20,
                      ),
                      Text(
                        '私人FM',
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
