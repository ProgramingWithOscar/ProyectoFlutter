import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/theme/theme_provider.dart'; // Importa el paquete necesario para Flutter.

class ContainerWidget extends StatelessWidget {
  // Define un widget personalizado llamado ContainerWidget que extiende StatelessWidget.
  final String url; // URL de la imagen que se mostrará en el contenedor.
  final String name; // Nombre o etiqueta que se mostrará en el contenedor.
  final VoidCallback?
      onTap; // Callback opcional que se activa cuando se toca el contenedor.

  const ContainerWidget({
    // Constructor que recibe los datos necesarios para construir el widget.
    Key? key,
    required this.url, // La URL de la imagen es obligatoria.
    required this.name, // El nombre es obligatorio.
    required this.onTap, // La función de retorno es opcional.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define el método 'build' para construir el widget.
    return GestureDetector(
      // Utiliza un GestureDetector para detectar toques en el contenedor.
      onTap: onTap, // Asigna la función de retorno onTap al detector de toques.
      child: Center(
        heightFactor: 0,
        // Centra el contenido dentro del contenedor.
        child: ClipRRect(
          // Utiliza un ClipRRect para aplicar bordes redondeados al contenedor.
          borderRadius: BorderRadius.circular(
              20), // Establece un radio de 20 para los bordes redondeados.
          child: Container(
            
            width: 120, // Ancho del contenedor.
            height: 160, // Altura del contenedor.
            margin: const EdgeInsets.symmetric(
                horizontal: 10), // Márgenes horizontales del contenedor.
            child: _Card(url: url, name: name),
          ),
        ),
      ),
    );
    
  }
}

class _Card extends ConsumerWidget {
  
  const _Card({
    super.key,
    required this.url,
    required this.name,
  });

  final String url;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    return Column(
      // Utiliza un Stack para superponer elementos en el contenedor.
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
          
            // Muestra la imagen desde un recurso local.
            url,
            fit: BoxFit
                .cover, // Ajusta la imagen para que cubra todo el contenedor.
            width: 120, // Ancho de la imagen.
            height: 120, // Altura de la imagen.
          ),
        ),
        
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Center(
            
            // Centra el texto en el contenedor.
            child: Text(
              // Muestra el nombre del elemento.
              name,
              maxLines: 2,
              style: TextStyle(
                // Estilo del texto del nombre.
                color: isDarkMode ? Colors.white : Colors.black, // Color del texto en negro.
                fontSize: 10, // Tamaño de fuente 16.
                fontWeight: FontWeight.bold, // Texto en negrita.
              ),
            ),
          ),
        ),
      ],
    );
  }
}
