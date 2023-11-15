import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/auth_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/pages/user/models/user_model.dart';
import 'package:yes_play_music/utils/size.dart';

class UserTopComponent extends StatelessWidget {
  const UserTopComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        if (authState is LogoutState) {
          return Container();
        }
        UserModel user = (authState as LoginState).user;
        return Container(
            width: SizeUtil.screenWidth(context),
            color: themeState.backgroundColor,
            height: 430,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    width: SizeUtil.screenWidth(context),
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image:
                              CachedNetworkImageProvider(user.backgroundUrl)),
                    ),
                  ),
                ),
                Positioned(
                    top: 100,
                    child: Container(
                      width: SizeUtil.screenWidth(context) * 0.7,
                      height: 300,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: themeState.settingBgColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              clipBehavior: Clip.hardEdge,
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child:
                                  CachedNetworkImage(imageUrl: user.avatarUrl)),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              user.nickName,
                              style: TextStyle(
                                  color: themeState.mainTextColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            user.signature,
                            style: TextStyle(
                                color: themeState.mainTextColor, fontSize: 18),
                          )
                        ],
                      ),
                    ))
              ],
            ));
      });
    });
  }
}
