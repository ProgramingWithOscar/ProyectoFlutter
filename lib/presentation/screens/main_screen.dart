import 'package:flutter/material.dart';
import 'package:storemap/presentation/screens/fisrt_screen.dart';
import 'package:storemap/presentation/screens/map_screen.dart';
import 'package:storemap/presentation/screens/products_screen.dart';
import 'package:storemap/presentation/containers/bottom_navigator.dart';
import 'package:storemap/presentation/screens/profile_screen.dart';
import 'package:storemap/presentation/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BotonNavegacion(
          onTabSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: <Widget>[
            const FisrtScreen(),
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
