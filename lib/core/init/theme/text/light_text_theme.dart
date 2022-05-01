import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipeapp/core/init/theme/text/text_theme.dart';

import '../color/color_theme.dart';

class TextThemeLight implements ITextTheme {
  @override
  TextStyle? bodyText1;

  @override
  TextStyle? bodyText2;

  @override
  late final TextTheme data;

  @override
  String? fontFamily;

  @override
  TextStyle? headline1;

  @override
  TextStyle? headline3;

  @override
  TextStyle? headline4;

  @override
  TextStyle? headline5;

  @override
  TextStyle? headline6;

  @override
  TextStyle? subtitle1;

  @override
  TextStyle? subtitle2;

  @override
  Color? primaryColor;

  @override
  TextStyle? caption;

  TextThemeLight(this.primaryColor) {
    data = const TextTheme(
      headline6: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 20.0),
      headline4: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headline3: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    ).apply(
        bodyColor: AppColors().black,
        fontFamily: fontFamily,
        displayColor: AppColors().black);
    fontFamily = GoogleFonts.quicksand().fontFamily;
  }
}
