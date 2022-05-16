import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/core/init/theme/app_theme.dart';

import 'feature/AddFood/view/addFood_screen.dart';
import 'feature/HomePage/view/homePage_screen.dart';
import 'feature/Onboard/view/onboard_screen.dart';
import 'feature/SearchPage/view/SearchPage_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.createTheme(AppThemeLight()),
      home: AddFoodItem(),
    );
  }
}
