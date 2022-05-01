import 'package:flutter/material.dart';

class AppColors {
  final Color green = const Color(0xff1FCC79);
  final Color red = const Color(0xffFF5842);
  final Color white = const Color(0xffffffff);
  final Color black = const Color(0xff2E3E5C);
  final Color grey = const Color(0xffD0DBEA);
  final Color lightGrey = const Color(0xffF4F5F7);
  final Color darkGrey = const Color(0xff9FA5C0);
  final Color brightRed = const Color(0xffFF5842);
  final Color turkuaz= const Color(0xffE3FFF8);
}

abstract class IColors {
  AppColors get colors;
  Color? scaffoldBackgroundColor;
  Color? appBarColor;
  Color? tabBarColor;
  Color? tabbarSelectedColor;
  Color? tabbarNormalColor;
  Brightness? brightness;
  Color? buttonNormalColor;
  Color? buttonSelectedColor;
  Color? buttonGoogleColor;
  Color? inputTextButtonColor;
  ColorScheme? colorScheme;
}
