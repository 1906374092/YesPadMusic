import 'dart:ui';

import 'package:flutter/material.dart';

class BlurPlayButton extends StatelessWidget {
  final double size;
  const BlurPlayButton({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(size / 2)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          )),
    );
  }
}
