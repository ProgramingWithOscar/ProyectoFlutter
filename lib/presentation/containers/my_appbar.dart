import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/theme/theme_provider.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define un widget llamado MyAppBar que extiende ConsumerWidget y PreferredSizeWidget.
    // PreferredSizeWidget se utiliza para especificar la altura preferida de la barra de aplicaciones.

    bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    // Obtiene el valor actual del modo oscuro desde el proveedor de tema utilizando ref.watch.

    return AppBar(
      // Crea una AppBar personalizada.
      backgroundColor: isDarkMode ? Colors.black12 : Colors.white,
      // Establece el color de fondo de la AppBar, dependiendo del modo oscuro o claro.
      elevation: 0,
      // Establece la elevación de la AppBar (sin sombra).

      actions: [
        // Define acciones en la AppBar.
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Agrega aquí la lógica de búsqueda si es necesario.
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            // Agrega aquí acciones adicionales si es necesario.
          },
        ),
      ],

      title: TextField(
        // Agrega un campo de texto en la AppBar.
        decoration: InputDecoration(
          hintText: 'Buscar...',
          // Establece un texto de sugerencia en el campo de entrada.
          filled: true,
          // Activa el relleno del campo de entrada.
          fillColor: isDarkMode ? Colors.blueGrey[900] : Colors.white,
          // Establece el color de relleno del campo de entrada según el modo oscuro o claro.
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            // Establece un borde invisible alrededor del campo de entrada.
            borderRadius: BorderRadius.circular(8.0),
            // Establece bordes redondeados para el campo de entrada.
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          // Establece el espaciado interno del campo de entrada.
        ),
        // Agrega aquí el controlador y lógica de búsqueda si es necesario.
      ),
    );
  }
}



