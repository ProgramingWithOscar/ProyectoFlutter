import 'package:flutter/material.dart';

List<Color> colors = [Colors.blue, Colors.green, Colors.red];

class AppTheme {
  int selectedColor;

  AppTheme({this.selectedColor = 0});

    ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      // brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colors[selectedColor],
      appBarTheme: const AppBarTheme(
        centerTitle: true,//cemtra los titulos de los appbar
      ));
}
