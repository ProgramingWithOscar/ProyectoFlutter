import 'package:flutter/material.dart';  // Importa el paquete necesario para Flutter.
import 'package:storemap/presentation/screens/fisrt_screen.dart';  // Importa la pantalla FirstScreen.
import 'package:storemap/presentation/screens/map_screen.dart';  // Importa la pantalla MapScreen.
import 'package:storemap/presentation/screens/products_screen.dart';  // Importa la pantalla ProductsScreen.
import 'package:storemap/presentation/containers/bottom_navigator.dart';  // Importa el contenedor BottomNavigator.
import 'package:storemap/presentation/screens/profile_screen.dart';  // Importa la pantalla ProfileScreen.
import 'package:storemap/presentation/screens/settings_screen.dart';  // Importa la pantalla SettingsScreen.

class MainScreen extends StatefulWidget {  // Define la clase MainScreen que extiende StatefulWidget.
  @override
  State<MainScreen> createState() => _MainScreenState();  // Crea el estado para MainScreen.
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;  // Índice de la pantalla seleccionada.

  @override
  Widget build(BuildContext context) {  // Define el método 'build' para construir la pantalla.
    return SafeArea(  // Asegura que el contenido no se coloque debajo de las barras de sistema.
      child: Scaffold(
        backgroundColor: Colors.white,  // Define la estructura básica de la pantalla.
        bottomNavigationBar: BotonNavegacion(  // Agrega una barra de navegación en la parte inferior.
          onTabSelected: (index) {  // Función que se ejecuta cuando se selecciona una pestaña.
            setState(() {  // Actualiza el estado de la aplicación.
              selectedIndex = index;  // Actualiza el índice de la pantalla seleccionada.
            });
          },
        ),
        body: IndexedStack(  // Permite apilar varias pantallas y mostrar solo una a la vez.
          index: selectedIndex,  // Índice de la pantalla que se mostrará.
          children: <Widget>[  // Lista de pantallas disponibles.
            const FirstScreen(),  // Pantalla FirstScreen.
            const ProductsScreen(),  // Pantalla ProductsScreen.
            const MapScreen(),  // Pantalla MapScreen.
            const ProfileScreen(),  // Pantalla ProfileScreen.
            ConfiguracionScreen()  // Pantalla ConfiguracionScreen.
          ],
        ),
      ),
    );
  }
}

