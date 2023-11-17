import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';
import 'package:yes_play_music/component/appbar.dart';
import 'package:yes_play_music/pages/user/components/settings_component.dart';
import 'package:yes_play_music/pages/user/components/user_top_component.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Scaffold(
        appBar: const CommonAppBar(
          title: '帐户',
          titleColor: Colors.white,
          leftBtnColor: Colors.white,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            color: themeState.backgroundColor,
            child: const Column(
              children: [UserTopComponent(), SettingsComponet()],
            ),
          ),
        ),
      );
    });
  }
}
