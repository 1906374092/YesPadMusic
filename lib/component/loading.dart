import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yes_play_music/blocs/theme_bloc.dart';

class Loading extends StatefulWidget {
  final String? status;
  const Loading({super.key, this.status = '努力加载中'});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    EasyLoading.show(status: widget.status);
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        EasyLoading.instance
          ..indicatorType = EasyLoadingIndicatorType.chasingDots
          ..loadingStyle = state is LightThemeState
              ? EasyLoadingStyle.dark
              : EasyLoadingStyle.light;
        return Container();
      },
    );
  }
}
