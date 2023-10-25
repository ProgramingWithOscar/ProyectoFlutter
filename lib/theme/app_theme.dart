import 'package:flutter/material.dart';
import 'package:storemap/theme/theme_provider.dart';

List<Color> colors = [Colors.blue, Colors.green, Colors.red];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;
  AppTheme({this.selectedColor = 0, this.isDarkMode = false});

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark: Brightness.light,
      colorSchemeSeed: colors[selectedColor],
      appBarTheme: const AppBarTheme(
        centerTitle: true, //cemtra los titulos de los appbar
      ));

  AppTheme copyWith({int? selectedColor, bool? isDarkMode}) => AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode);
}
