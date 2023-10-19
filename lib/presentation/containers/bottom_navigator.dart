import 'package:flutter/material.dart';
import 'package:storemap/presentation/screens/fisrt_screen.dart';
import 'package:storemap/presentation/screens/map_screen.dart';
import 'package:storemap/presentation/screens/products_screen.dart';
import 'package:storemap/presentation/screens/profile_screen.dart';
import 'package:storemap/presentation/screens/settings_screen.dart';

class BotonNavegacion extends StatefulWidget {
  final ValueChanged<int> onTabSelected; // Añade un callback

  const BotonNavegacion({required this.onTabSelected, Key? key})
      : super(key: key);

  @override
  State<BotonNavegacion> createState() => BotonNavegacionState();
}

class BotonNavegacionState extends State<BotonNavegacion> {
  int selectedIndex = 0;
  final List<Widget> pages = <Widget>[
    const FirstScreen(),
    const ProductsScreen(),
    const MapScreen(),
    const ProfileScreen(),
     ConfiguracionScreen()
  ];
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (int index) {
        setState(() {
          selectedIndex = index;
          widget.onTabSelected(index); // Notifica al MainScreen sobre el cambio
        });
      },
      iconSize: 20,
      backgroundColor: Colors.green, // Establece un color de fondo blanco
      unselectedItemColor:
          Colors.green, // Establece un color para los íconos no seleccionados
      selectedItemColor:
          Colors.blue, // Establece un color para el ícono seleccionado
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store_mall_directory),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
        // Agrega más elementos aquí según sea necesario
      ],
    );
  }
}
