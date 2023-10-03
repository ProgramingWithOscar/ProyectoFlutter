import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + 40); // Altura deseada del AppBar

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [],
      bottom: const PreferredSize(
        preferredSize:
            Size.fromHeight(10), // Altura deseada de la barra de búsqueda
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar...',
              border: OutlineInputBorder(),
              prefixIcon:
                  Icon(Icons.search), // Icono de búsqueda dentro del TextField
            ),
            // Agrega aquí el controlador y lógica de búsqueda si es necesario
          ),
        ),
      ),
    );
  }
}
