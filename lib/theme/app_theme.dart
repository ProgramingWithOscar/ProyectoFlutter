import 'package:flutter/material.dart';
import 'package:storemap/theme/theme_provider.dart';

List<Color> colors = [Colors.blue, Colors.green, Colors.red];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  // Constructor de la clase AppTheme
  AppTheme({this.selectedColor = 0, this.isDarkMode = false});

  // Método que devuelve el tema de la aplicación basado en las propiedades
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colors[selectedColor],
      appBarTheme: const AppBarTheme(
        centerTitle: true, // Centro el título de los AppBar
      ));

  // Método que crea una copia de la instancia de AppTheme con valores opcionales
  AppTheme copyWith({int? selectedColor, bool? isDarkMode}) => AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode);
}

