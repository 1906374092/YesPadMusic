import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/assets/imageCode/flutter_assets.dart';
import 'package:yes_play_music/blocs/auth_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/music_store/components/music_store_component.dart';
import 'package:yes_play_music/utils/size.dart';

class MusicStorePage extends StatefulWidget {
  const MusicStorePage({super.key});

  @override
  State<MusicStorePage> createState() => _MusicStorePageState();
}

class _MusicStorePageState extends State<MusicStorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        if (authState is LogoutState) {
          return Container(
            color: themeState.backgroundColor,
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImages.neteaseMusic,
                    width: SizeUtil.screenWidth(context) / 10,
                    height: SizeUtil.screenWidth(context) / 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: SizeUtil.screenWidth(context) / 3,
                      height: SizeUtil.screenWidth(context) / 7,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: themeState.lightBlueColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        '登录网易云账号',
                        style: TextStyle(
                            color: themeState.darkBlueColor, fontSize: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const MusicStoreComponent();
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
