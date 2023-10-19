import 'package:flutter/material.dart';
import 'package:storemap/presentation/screens/auth_screen.dart';
import 'package:storemap/presentation/screens/fisrt_screen.dart';
import 'package:storemap/presentation/screens/main_screen.dart';

import 'package:storemap/presentation/screens/register_screen.dart';
import 'package:storemap/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Map',
      /**
       * theme recibe una clase personalizada llamada appTheme que retorna un ThemeData, lo cual 
       * nos proporciona los temas de la aplicacion mediante un metodo .getTheme()
       */ 
      theme: AppTheme(selectedColor: 0).getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // Rutas de la aplicacion
      routes: {
        '/': (context) => MainScreen(),
        '/register': (context) => SignupPage(),
      },
    );
  }
}
