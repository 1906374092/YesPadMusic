import 'package:flutter/material.dart';

class MusicControls extends StatelessWidget {
  final bool? white;
  final double? size;
  const MusicControls({super.key, this.white = true, this.size = 30});

  @override
  Widget build(BuildContext context) {
    Color iconColor = white! ? Colors.white : Colors.black;
    return SizedBox(
      height: size! + 10,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.heart_broken,
                color: iconColor,
                size: size,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow,
                color: iconColor,
                size: size,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.skip_next,
                color: iconColor,
                size: size,
              ))
        ],
      ),
    );
  }
}
