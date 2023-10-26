import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leftBtn;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Function()? closeCallback;
  const CommonAppBar(
      {super.key,
      required this.title,
      this.leftBtn,
      this.actions = const [],
      this.bottom,
      this.closeCallback});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return AppBar(
          title: Text(title),
          titleTextStyle: TextStyle(
              color: state.mainTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          centerTitle: true,
          leading: leftBtn ??
              IconButton(
                  onPressed: () {
                    closeCallback!();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: state.mainTextColor,
                  )),
          actions: actions,
          bottom: bottom,
          backgroundColor: (state.backgroundColor as Color).withOpacity(0.4),
          elevation: 0.0,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size(AppBar().preferredSize.width,
      AppBar().preferredSize.height + (bottom == null ? 0 : 44));
}
