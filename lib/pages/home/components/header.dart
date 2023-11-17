import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';

class Header extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool? showAllBtn;
  final Function()? action;
  const Header(
      {super.key,
      required this.title,
      this.showAllBtn = true,
      this.action,
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(15),
          child: showAllBtn!
              ? Row(
                  children: [
                    Text(
                      title,
                      style: titleStyle ??
                          TextStyle(
                              color: themeState.mainTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          if (action != null) action!();
                        },
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
