import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/footer.dart';
import 'package:yes_play_music/pages/discover/blocs/discover_bloc.dart';
import 'package:yes_play_music/pages/discover/components/playlist_card.dart';
import 'package:yes_play_music/pages/discover/data/discover_repository.dart';
import 'package:yes_play_music/utils/size.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => DiscoverBloc(repository: DiscoverRepository())
        ..add(DiscoverCardGetCategoryDataEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return BlocBuilder<DiscoverBloc, DiscoverState>(
            builder: (context, discoverState) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: discoverState.backgroundColor)),
            height: SizeUtil.screenHeight(context),
            width: SizeUtil.screenWidth(context),
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                SizedBox(
                    height: SizeUtil.screenHeight(context) - 154 - 80,
                    child: Swiper(
                      itemCount: discoverState.categories.length,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 0.8,
                      loop: true,
                      scale: 0.8,
                      onIndexChanged: (value) => context
                          .read<DiscoverBloc>()
                          .add(DiscoverCardScrolledEvent()),
                      itemBuilder: (context, index) {
                        return PlayListCard(index: index);
                      },
                    )),
                const CommonFooter()
              ],
            ),
          );
        });
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
