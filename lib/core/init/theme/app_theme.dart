import 'package:flutter/material.dart';
import 'package:recipeapp/core/init/theme/color/app_theme_light.dart';
import 'package:recipeapp/core/init/theme/color/color_theme.dart';
import 'package:recipeapp/core/init/theme/text/light_text_theme.dart';
import 'package:recipeapp/core/init/theme/text/text_theme.dart';

abstract class ITheme {
  ITextTheme get textTheme;
  IColors get colors;
}

abstract class ThemeManager {
  static ThemeData createTheme(ITheme theme) => ThemeData(
        scaffoldBackgroundColor: AppColors().white,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors().turkuaz,
        ),
        fontFamily: theme.textTheme.fontFamily,
        textTheme: theme.textTheme.data,
        cardColor: theme.colors.colorScheme?.onSecondary,
        bottomAppBarColor: theme.colors.scaffoldBackgroundColor,
        tabBarTheme: TabBarTheme(
          indicator: const BoxDecoration(),
          labelColor: theme.colors.tabbarSelectedColor,
          unselectedLabelColor: theme.colors.tabbarNormalColor,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: theme.colors.appBarColor,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black, size: 25)),
        colorScheme: theme.colors.colorScheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
              primary: theme.colors.colorScheme?.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              textStyle: const TextStyle(
                  wordSpacing: 2,
                  letterSpacing: 1,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              backgroundColor: theme.colors.buttonNormalColor),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
        ),
        
      );
}

// class AppThemeDark extends ITheme {
//   @override
//   late final ITextTheme textTheme;
//   AppThemeDark() {
//     textTheme = TextThemeDark(colors.colors.mediumGrey);
//   }

//   @override
//   IColors get colors => DarkColors();
// }

class AppThemeLight extends ITheme {
  @override
  late final ITextTheme textTheme;
  AppThemeLight() {
    textTheme = TextThemeLight(colors.colors.black);
  }

  @override
  IColors get colors => LightColors();
}
