import 'package:flutter/material.dart';  // Importa el paquete necesario para Flutter.
import 'package:storemap/presentation/screens/fisrt_screen.dart';  // Importa la primera pantalla.
import 'package:storemap/presentation/screens/map_screen.dart';  // Importa la pantalla del mapa.
import 'package:storemap/presentation/screens/products_screen.dart';  // Importa la pantalla de productos.
import 'package:storemap/presentation/screens/profile_screen.dart';  // Importa la pantalla de perfil de usuario.
import 'package:storemap/presentation/screens/settings_screen.dart';  // Importa la pantalla de configuración.

class BotonNavegacion extends StatefulWidget {  // Define la clase BotonNavegacion que extiende StatefulWidget.
  final ValueChanged<int> onTabSelected; // Añade un callback que se ejecutará cuando se seleccione una pestaña.

  const BotonNavegacion({required this.onTabSelected, Key? key})
      : super(key: key);

  @override
  State<BotonNavegacion> createState() => BotonNavegacionState();  // Crea un estado para el widget de navegación.
}

class BotonNavegacionState extends State<BotonNavegacion> {  // Define el estado del widget de navegación.
  int selectedIndex = 0;  // Índice de la pestaña seleccionada.
  final List<Widget> pages = <Widget>[  // Lista de páginas disponibles.
    const FirstScreen(),  // Primera pantalla.
    const ProductsScreen(),  // Pantalla de productos.
    const MapScreen(),  // Pantalla de mapa.
    const ProfileScreen(),  // Pantalla de perfil de usuario.
    ConfiguracionScreen()  // Pantalla de configuración.
  ];
  
  @override
  Widget build(BuildContext context) {  // Define el método 'build' para construir el widget de navegación.
    return BottomNavigationBar(  // Widget de barra de navegación inferior.
      currentIndex: selectedIndex,  // Índice de la pestaña actual.
      onTap: (int index) {  // Función que se ejecuta cuando se toca una pestaña.
        setState(() {  // Actualiza el estado del widget.
          selectedIndex = index;  // Actualiza el índice de la pestaña seleccionada.
          widget.onTabSelected(index);  // Notifica al widget padre (MainScreen) sobre el cambio de pestaña.
        });
      },
      iconSize: 20,  // Tamaño de los íconos.
      backgroundColor: Colors.green, // Establece un color de fondo para la barra de navegación.
      unselectedItemColor: Colors.green, // Establece un color para los íconos no seleccionados.
      selectedItemColor: Colors.blue, // Establece un color para el ícono seleccionado.
      items: const <BottomNavigationBarItem>[  // Lista de elementos de la barra de navegación.
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),  // Ícono de inicio.
          label: 'Home',  // Etiqueta de inicio.
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store_mall_directory),  // Ícono de tienda.
          label: 'Shop',  // Etiqueta de tienda.
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),  // Ícono de mapa.
          label: 'Map',  // Etiqueta de mapa.
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),  // Ícono de perfil.
          label: 'Profile',  // Etiqueta de perfil.
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),  // Ícono de configuración.
          label: 'Settings',  // Etiqueta de configuración.
        ),
        // Agrega más elementos aquí según sea necesario.
      ],
    );
  }
}
