import 'package:flutter/material.dart';

class AppRouter {
  //页面路由配置
  final Map _routes = {};

  Route? onGenerateRoute(RouteSettings settings) {
    return _routes[settings.name];
  }

  void dispose() {}
}
