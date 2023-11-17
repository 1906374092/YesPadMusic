import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/playlist_detail/blocs/playlist_detail_bloc.dart';
import 'package:yes_play_music/utils/size.dart';
import 'package:yes_play_music/utils/tools.dart';

class PlaylistDetailInfoComponent extends StatelessWidget {
  PlaylistDetailInfoComponent({super.key});
  final TextStyle _detailStyle =
      TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<PlaylistDetailBloc, PlaylistDetailState>(
          builder: (context, detailState) {
        if (detailState.model == null) {
          return Container();
        }
        return Container(
          width: SizeUtil.screenWidth(context),
          height: 300,
          color: Colors.transparent,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 260,
                height: 260,
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: themeState.secondTextColor,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ]),
                child: CachedNetworkImage(
                    imageUrl: detailState.model!.coverImgUrl),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailState.model!.name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                              imageUrl: detailState.model!.creator!.avatarUrl),
                        ),
                        Text(
                          detailState.model!.creator!.nickName,
                          style: _detailStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SizeUtil.screenWidth(context) - 320,
                    child: Row(
                      children: [
                        Text(
                          '最后更新于${Tools.getFullDateTimeString(detailState.model!.updateTime.toInt())}',
                          style: _detailStyle,
                        ),
                        const Spacer(),
                        Text(
                          '${detailState.model!.trackCount}首歌・${Tools.getNumberLabel(detailState.model!.playCount.toInt())}播放',
                          style: _detailStyle,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: SizeUtil.screenWidth(context) - 320,
                    height: 120,
                    padding: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      child: Text(
                        detailState.model!.description,
                        style: _detailStyle,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      });
    });
  }
}
