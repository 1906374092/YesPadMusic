import 'package:flutter/material.dart';
import 'package:yes_play_music/utils/size.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeUtil.screenWidth(context),
      height: 80,
    );
  }
}
