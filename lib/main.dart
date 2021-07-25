import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/utils/api.dart';
import 'package:wallpaper_app/utils/db_provider.dart';

void main() async {
  runApp(MyApp());
  //DataBaseProvider dataBaseProvider;
  kDatabase = await DataBaseProvider.instance.database;
}

class AppThemes {
  static const int LightBlue = 0;
  static const int LightRed = 1;
  static const int Dark = 2;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.LightBlue: ThemeData(primarySwatch: Colors.blue),
    AppThemes.LightRed: ThemeData(primarySwatch: Colors.red),
    AppThemes.Dark: ThemeData.dark(),
  },
  fallbackTheme: ThemeData.light(),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      builder: (context, theme) {
        return MaterialApp(
          title: 'Wallpaper Lovers',
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        );
      },
      themeCollection: themeCollection,
    );
  }
}

/* ThemeData(
            primarySwatch: Colors.deepPurple,
            backgroundColor: Colors.white70,
            brightness: Brightness.light,
          ), */
