import 'package:flutter/material.dart';

class SizeUtil {
  //屏幕宽高
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double topBarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top + 44.0;
}
