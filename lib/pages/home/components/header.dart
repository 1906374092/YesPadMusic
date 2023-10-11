import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme.dart';

class Header extends StatelessWidget {
  final String title;
  final bool? showAllBtn;
  const Header({super.key, required this.title, this.showAllBtn = true});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: showAllBtn!
              ? Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: themeState.mainTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '查看全部',
                          style: TextStyle(color: themeState.secondTextColor),
                        ))
                  ],
                )
              : Text(
                  title,
                  style: TextStyle(
                      color: themeState.mainTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
        );
      },
    );
  }
}
