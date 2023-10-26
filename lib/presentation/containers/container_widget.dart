import 'package:flutter/material.dart'; // Importa el paquete necesario para Flutter.

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
        // Centra el contenido dentro del contenedor.
        child: ClipRRect(
          // Utiliza un ClipRRect para aplicar bordes redondeados al contenedor.
          borderRadius: BorderRadius.circular(
              20), // Establece un radio de 20 para los bordes redondeados.
          child: Container(
            // Contenedor que muestra la imagen y el nombre.
            decoration: BoxDecoration(
              // Define un decorado para el contenedor.
              color: Colors.white, // Establece un color de fondo blanco.
              boxShadow: [
                // Agrega una sombra al contenedor.
                BoxShadow(
                  // Define las propiedades de la sombra.
                  color: Colors.grey.withOpacity(
                      1), // Color de la sombra con opacidad completa.
                  spreadRadius: 2, // Extensión de la sombra.
                  blurRadius: 3, // Difuminado de la sombra.
                  offset: const Offset(0, 0), // Desplazamiento de la sombra.
                ),
              ],
            ),
            width: 120, // Ancho del contenedor.
            height: 140, // Altura del contenedor.
            margin: const EdgeInsets.symmetric(
                horizontal: 10), // Márgenes horizontales del contenedor.
            child: Stack(
              // Utiliza un Stack para superponer elementos en el contenedor.
              children: [
                Image.network(
                  // Muestra la imagen desde un recurso local.
                  url,
                  fit: BoxFit
                      .cover, // Ajusta la imagen para que cubra todo el contenedor.
                  width: 120, // Ancho de la imagen.
                  height: 160, // Altura de la imagen.
                ),
                Positioned(
                  // Posiciona un elemento dentro del Stack.
                  bottom: 0, // Coloca el elemento en la parte inferior.
                  left: 0, // Coloca el elemento en la parte izquierda.
                  right: 0, // Coloca el elemento en la parte derecha.
                  child: Container(
                    // Contenedor que muestra el nombre del elemento.
                    color: Colors.white
                        .withOpacity(0.6), // Fondo semitransparente blanco.
                    child: Center(
                      // Centra el texto en el contenedor.
                      child: Text(
                        // Muestra el nombre del elemento.
                        name,
                        style: const TextStyle(
                          // Estilo del texto del nombre.
                          color: Colors.black, // Color del texto en negro.
                          fontSize: 15, // Tamaño de fuente 16.
                          fontWeight: FontWeight.bold, // Texto en negrita.
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
