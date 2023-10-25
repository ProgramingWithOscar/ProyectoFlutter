import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/theme/theme_provider.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    return AppBar(
      backgroundColor: isDarkMode ? Colors.black12 : Colors.white, // Color de fondo blanco
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
          fillColor: isDarkMode ? Colors.blueGrey[900] : Colors.white, // Color de relleno gris claro
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


