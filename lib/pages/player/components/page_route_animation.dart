import 'package:flutter/material.dart';

class OpenPlayerPageRoute extends PageRouteBuilder {
  final Widget widget;
  OpenPlayerPageRoute(this.widget)
      : super(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                    .animate(CurvedAnimation(
                        parent: animation, curve: Curves.linearToEaseOut)),
                child: child,
              );
            });
}

class CommonPageRoute extends PageRouteBuilder {
  final Widget widget;
  CommonPageRoute(this.widget)
      : super(
            transitionDuration: const Duration(milliseconds: 600),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.fastEaseInToSlowEaseOut)),
                child: child,
              );
            });
}
