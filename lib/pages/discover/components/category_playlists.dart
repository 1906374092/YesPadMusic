import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/pages/discover/blocs/category_bloc.dart';
import 'package:yes_play_music/pages/discover/blocs/discover_bloc.dart';
import 'package:yes_play_music/pages/discover/models/playlist_detail_model.dart';
import 'package:yes_play_music/utils/size.dart';
import 'package:yes_play_music/utils/tools.dart';

class CategoryPlaylistsComponent extends StatelessWidget {
  final String category;
  const CategoryPlaylistsComponent({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, discoverState) {
      return BlocProvider(
        create: (context) => CategoryInfoBloc(
            repository: context.read<DiscoverBloc>().repository)
          ..add(GetPlaylistDataWithCategoryEvent(category: category)),
        child: BlocBuilder<CategoryInfoBloc, CategoryInfoState>(
          builder: (context, categoryInfoState) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: categoryInfoState.playlists.length,
                itemBuilder: (BuildContext context, int index) {
                  PlayListDetailModel model =
                      categoryInfoState.playlists[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/playlist/detail',
                          arguments: {'title': model.name, 'id': model.id});
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.only(top: 20),
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.8),
                          image: DecorationImage(
                              opacity: 0.6,
                              scale: 0.1,
                              fit: BoxFit.none,
                              image: NetworkImage(model.coverImgUrl))),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      clipBehavior: Clip.hardEdge,
                                      child: CachedNetworkImage(
                                          imageUrl: model.coverImgUrl),
                                    ),
                                    Positioned(
                                      right: 25,
                                      child: Container(
                                        height: 30,
                                        margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.play_arrow_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              '${model.playCount ~/ 10000}万',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        model.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              'by ${model.creator!.nickName}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '最后更新 ${Tools.getFullDateTimeString(model.updateTime.toInt())}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}
