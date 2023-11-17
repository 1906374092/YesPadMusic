import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/utils/size.dart';

class ArtistDetailShimmer extends StatelessWidget {
  const ArtistDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Container(
        padding: const EdgeInsets.all(20),
        color: themeState.backgroundColor,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        color: Colors.grey),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 40,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: SizeUtil.screenWidth(context) - 400,
                        height: 100,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ],
              ),
              Container(
                width: 150,
                height: 40,
                color: Colors.grey,
                margin: const EdgeInsets.only(top: 30, bottom: 30),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: SizeUtil.screenWidth(context) - 40,
                height: 300,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
    });
  }
}
