import 'package:flutter/material.dart';
import 'package:storemap/presentation/screens/fisrt_screen.dart';
import 'package:storemap/presentation/screens/map_screen.dart';
import 'package:storemap/presentation/screens/products_screen.dart';
import 'package:storemap/presentation/containers/bottom_navigator.dart';
import 'package:storemap/presentation/screens/profile_screen.dart';
import 'package:storemap/presentation/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();//crea el nav y la posciona por encima de todas las screen
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(//scaffold es una pantalla
        bottomNavigationBar: BotonNavegacion(
          onTabSelected: (index) {//ontab viene de botonNavegation y resive el estado
            setState(() {//actuliza el estado
              selectedIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: selectedIndex,//cada vez que selecccione me actuliza el index y trae el nuevo screan
          children: <Widget>[
            const FirstScreen(),
            const ProductsScreen(),
            const MapScreen(),
            const ProfileScreen(),
            ConfiguracionScreen()
          ],
        ),
      ),
    );
  }
}
