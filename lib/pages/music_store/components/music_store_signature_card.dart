import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/auth_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/player/play_button.dart';
import 'package:yes_play_music/pages/music_store/blocs/music_store_bloc.dart';
import 'package:yes_play_music/pages/player/blocs/player_bloc.dart';
import 'package:yes_play_music/pages/user/models/user_model.dart';
import 'package:yes_play_music/utils/size.dart';

class MusicStoreSignatureCard extends StatelessWidget {
  const MusicStoreSignatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      UserModel user = (authState as LoginState).user;

      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return BlocBuilder<MusicStoreBloc, MusicStoreState>(
            builder: (context, musicStoreState) {
          return Container(
            width: SizeUtil.screenWidth(context) / 3,
            height: SizeUtil.screenWidth(context) / 6,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: themeState.lightBlueColor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                SizedBox(
                  width: SizeUtil.screenWidth(context) / 3 - 40,
                  child: Text(
                    user.signature,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: themeState.darkBlueColor),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '我喜欢的音乐',
                          style: TextStyle(
                              color: themeState.darkBlueColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            '${musicStoreState.likedSongs.length}首歌',
                            style: TextStyle(
                                color: themeState.darkBlueColor, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    BlurPlayButton(
                      size: 50,
                      onPressed: () {
                        context.read<MusicPlayerBloc>().add(
                            StartPlayMusicAction(
                                songDetail: musicStoreState.likedSongs[0]));
                      },
                    )
                  ],
                ),
              ],
            ),
          );
        });
      });
    });
  }
}
