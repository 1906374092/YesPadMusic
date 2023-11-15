import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/auth_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/utils/size.dart';

class SettingsComponet extends StatelessWidget {
  const SettingsComponet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      double width = SizeUtil.screenWidth(context) * 0.7;
      double height = 70.0;
      BoxDecoration outer = BoxDecoration(
        color: themeState.settingBgColor,
        borderRadius: BorderRadius.circular(20),
      );
      TextStyle settingTitleStyle = TextStyle(
          color: themeState.mainTextColor,
          fontSize: 18,
          fontWeight: FontWeight.bold);
      return Container(
        color: themeState.backgroundColor,
        child: Column(
          children: [
            Container(
              width: width,
              height: height,
              decoration: outer,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    '深色模式',
                    style: settingTitleStyle,
                  ),
                  const Spacer(),
                  Switch(
                    value: themeState is DarkThemeState,
                    onChanged: (value) {
                      if (value) {
                        context.read<ThemeBloc>().add(DarkThemeEvent());
                      } else {
                        context.read<ThemeBloc>().add(LightThemeEvent());
                      }
                    },
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(LogoutEvent());
              },
              child: Container(
                  width: width,
                  height: height,
                  decoration: outer,
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(
                    '退出登录',
                    style: TextStyle(
                        color: themeState.darkBlueColor, fontSize: 20),
                  )),
            )
          ],
        ),
      );
    });
  }
}
