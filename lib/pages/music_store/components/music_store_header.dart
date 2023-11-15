import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/auth_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/music_store/components/music_store_liked_list.dart';
import 'package:yes_play_music/pages/music_store/components/music_store_signature_card.dart';
import 'package:yes_play_music/pages/user/models/user_model.dart';

class MusicStoreHeader extends StatelessWidget {
  const MusicStoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        UserModel user = (authState as LoginState).user;

        return Container(
          padding: const EdgeInsets.all(30),
          color: themeState.backgroundColor,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.only(right: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: CachedNetworkImage(
                      imageUrl: user.avatarUrl,
                    ),
                  ),
                  Text(
                    '${user.nickName}的音乐库',
                    style: TextStyle(
                        color: themeState.mainTextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  children: [MusicStoreSignatureCard(), MusicStoreLikedList()],
                ),
              )
            ],
          ),
        );
      });
    });
  }
}
