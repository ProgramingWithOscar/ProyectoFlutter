import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Color de fondo blanco
      elevation: 0, // Sin sombra
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Agrega aquí la lógica de búsqueda si es necesario
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            // Agrega aquí acciones adicionales si es necesario
          },
        ),
      ],
      title: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar...',
          filled: true, // Relleno del campo de entrada
          fillColor: Colors.grey[100], // Color de relleno gris claro
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Borde invisible
            borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10), // Espaciado interno
        ),
        // Agrega aquí el controlador y lógica de búsqueda si es necesario
      ),
    );
  }
}


