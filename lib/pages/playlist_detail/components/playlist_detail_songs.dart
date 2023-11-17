import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/music/vip_icon.dart';
import 'package:yes_play_music/pages/home/models/artist_model.dart';
import 'package:yes_play_music/pages/home/models/song_detail_model.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/pages/playlist_detail/blocs/playlist_detail_bloc.dart';
import 'package:yes_play_music/pages/playlist_detail/components/playlist_detail_info_component.dart';
import 'package:yes_play_music/utils/size.dart';
import 'package:yes_play_music/utils/tools.dart';

class PlaylistDetailSongsComponent extends StatelessWidget {
  final num id;
  final ScrollController controller;
  final Color refreshBg;
  final Color loadBg;
  const PlaylistDetailSongsComponent(
      {super.key,
      required this.id,
      required this.controller,
      required this.refreshBg,
      required this.loadBg});
  final double _itemHeight = 80.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<PlaylistDetailBloc, PlaylistDetailState>(
          builder: (context, detailState) {
        if (detailState.model == null) {
          return Container();
        }
        return EasyRefresh.builder(
            refreshOnStart: true,
            header: BezierCircleHeader(backgroundColor: refreshBg),
            footer: BezierFooter(
                backgroundColor: loadBg,
                noMoreWidget: const Text(
                  '没有更多了',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
            onRefresh: () {
              context
                  .read<PlaylistDetailBloc>()
                  .add(PlaylistDetailGetNewTracksEvent(id: id));
            },
            onLoad: () {
              context
                  .read<PlaylistDetailBloc>()
                  .add(PlaylistDetailLoadMoreTracksEvent(id: id));
              if (detailState.tracks.length >=
                  detailState.model!.trackCount.toInt()) {
                return IndicatorResult.noMore;
              }
            },
            childBuilder: (context, physics) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: detailState.tracks.length + 1,
                physics: physics,
                controller: controller,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return PlaylistDetailInfoComponent();
                  }
                  SongDetailModel song = detailState.tracks[index - 1];
                  double radius = index == 1 ? 10 : 0;
                  double margin = index == 1 ? 20 : 0;
                  return GestureDetector(
                    onTap: () {
                      context
                          .read<MusicPlayerBloc>()
                          .add(StartPlayMusicAction(songDetail: song));
                    },
                    child: Container(
                      height: _itemHeight,
                      padding: const EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10, right: 10, top: margin),
                      decoration: BoxDecoration(
                          color: (themeState.backgroundColor as Color)
                              .withOpacity(0.8),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radius),
                              topRight: Radius.circular(radius))),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage(
                              imageUrl: song.album.picUrlMini,
                              placeholder: (context, url) => Container(
                                color: themeState.lightBlueColor,
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            width: SizeUtil.screenWidth(context) / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: themeState.mainTextColor,
                                      fontSize: 18),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Visibility(
                                      visible: song.fee == 1,
                                      child: const VipIcon(),
                                    ),
                                    SizedBox(
                                      width: SizeUtil.screenWidth(context) / 4,
                                      child: Text(
                                        ArtistModel.getArtistStrings(
                                            song.artists),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: (themeState.mainTextColor
                                                    as Color)
                                                .withOpacity(0.8),
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              song.album.name,
                              style: TextStyle(
                                  color: (themeState.mainTextColor as Color)
                                      .withOpacity(0.8),
                                  fontSize: 15),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            Tools.timeStringFromNum(song.durationTime),
                            style: TextStyle(
                                color: (themeState.mainTextColor as Color)
                                    .withOpacity(0.8),
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            });
      });
    });
  }
}
