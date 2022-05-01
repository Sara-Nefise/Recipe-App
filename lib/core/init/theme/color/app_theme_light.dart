import 'package:flutter/material.dart';

import 'color_theme.dart';

class LightColors implements IColors {
  @override
  Color? appBarColor;

  @override
  Brightness? brightness;

  @override
  ColorScheme? colorScheme;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Color? tabBarColor;

  @override
  Color? tabbarNormalColor;

  @override
  Color? tabbarSelectedColor;
  @override
  Color? inputTextButtonColor;
  @override
  Color? buttonSelectedColor;

  @override
  final AppColors colors = AppColors();

  LightColors() {
    appBarColor = colors.white;
    scaffoldBackgroundColor = colors.white;
    tabBarColor = colors.white;
    tabbarNormalColor = colors.darkGrey;
    tabbarSelectedColor = colors.green;

    buttonNormalColor = colors.green;
    buttonGoogleColor = colors.brightRed;
    inputTextButtonColor = colors.lightGrey;
    buttonSelectedColor = colors.green;
    colorScheme = const ColorScheme.light().copyWith(
        onPrimary: colors.white, //xx Her ikisinde ortaktır
        onSecondary: colors.red,
        onSurface: colors.lightGrey,
        primary: colors.black);
  }

  @override
  Color? buttonGoogleColor;

  @override
  Color? buttonNormalColor;
}
