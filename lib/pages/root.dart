import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/assets/imageCode/flutter_assets.dart';
import 'package:yes_play_music/blocs/theme.dart';
import 'package:yes_play_music/pages/discover/discover.dart';
import 'package:yes_play_music/pages/home/data/home_repository.dart';
import 'package:yes_play_music/pages/home/home.dart';
import 'package:yes_play_music/pages/music_store/music_store.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBlock, ThemeState>(builder: (context, state) {
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: state.backgroundColor,
            appBar: AppBar(
              title: const Text('Yes Play Music'),
              titleTextStyle: TextStyle(
                  color: state.mainTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              centerTitle: true,
              leading: IconButton(
                color: state.mainTextColor,
                icon: const Icon(Icons.search_rounded),
                onPressed: () {},
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: MaterialButton(
                    onPressed: () {},
                    child: CircleAvatar(
                      backgroundImage: AssetImages.defaultAvatar,
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                indicatorColor: state.indicatorColor,
                labelColor: state.indicatorColor,
                unselectedLabelColor: state.mainTextColor,
                labelStyle: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: '首页',
                  ),
                  Tab(
                    text: '发现',
                  ),
                  Tab(
                    text: '音乐库',
                  )
                ],
              ),
              backgroundColor:
                  (state.backgroundColor as Color).withOpacity(0.4),
              elevation: 0.0,
            ),
            body: TabBarView(
              children: [
                HomePage(repository: HomeRepository()),
                const DiscoverPage(),
                const MusicStorePage()
              ],
            ),
          ));
    });
  }
}