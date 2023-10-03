import 'package:flutter/material.dart'; // Importa la librería Flutter
import 'package:storemap/presentation/screens/auth_screen.dart';
import 'package:storemap/presentation/screens/register_screen.dart';

void main() {
  runApp(
      MyApp()); // Llama a la función runApp para iniciar la aplicación Flutter.
}

class MyApp extends StatelessWidget {
  // Define una clase llamada MyApp que extiende StatelessWidget.
  @override
  Widget build(BuildContext context) {
    // Define el método build para construir la interfaz de la aplicación.
    return MaterialApp(
        title: 'Store Map', // Título de la aplicación.
        theme: ThemeData(
          // brightness: Brightness.dark,
          useMaterial3: true,
          primarySwatch: Colors
              .blue, // Configura el tema de la aplicación con un color azul.
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // Ruta inicial de la aplicación.
        routes: {
          '/': (context) => RegisterScreen(), // Define una ruta llamada '/' que muestra AuthScreen.
          // '/register': (context) => RegisterScreen(),
        });
  }
}
