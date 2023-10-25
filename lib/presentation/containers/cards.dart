import 'package:flutter/material.dart';  // Importa el paquete necesario para Flutter.

class CardType1 extends StatelessWidget {  // Define un widget personalizado llamado CardType1 que extiende StatelessWidget.
  final String name;  // Nombre del producto.
  final String stars;  // Puntuación del producto en forma de estrellas.
  final String url;  // URL de la imagen del producto.
  final String price;  // Precio del producto.

  const CardType1({  // Constructor que recibe los datos necesarios para construir el widget.
    required this.name,  // El nombre es obligatorio.
    required this.stars,  // La puntuación es obligatoria.
    required this.url,  // La URL de la imagen es obligatoria.
    required this.price,  // El precio es obligatorio.
  });

  @override
  Widget build(BuildContext context) {  // Define el método 'build' para construir el widget.
    return Card(  // Utiliza un widget de tipo Card para mostrar la información del producto.
      elevation: 5,  // Establece la elevación del card.
      shape: RoundedRectangleBorder(  // Establece la forma del card con bordes redondeados.
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(  // Contenido del card, organizado en una columna.
        crossAxisAlignment: CrossAxisAlignment.start,  // Alinea el contenido a la izquierda.
        children: [
          Container(  // Contenedor para la imagen del producto.
            height: 150,  // Altura de la imagen.
            decoration: BoxDecoration(  // Define un decorado para la imagen con bordes redondeados.
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              image: DecorationImage(  // Configura la imagen de fondo del contenedor.
                image: NetworkImage(url),  // Carga la imagen desde una URL.
                fit: BoxFit.cover,  // Ajusta la imagen para que cubra todo el contenedor.
              ),
            ),
          ),
          Padding(  // Espacio de relleno alrededor del contenido de la columna.
            padding: const EdgeInsets.all(8.0),
            child: Column(  // Otra columna para mostrar el nombre, precio y puntuación del producto.
              crossAxisAlignment: CrossAxisAlignment.start,  // Alinea el contenido a la izquierda.
              children: [
                Text(  // Muestra el nombre del producto.
                  name,
                  style: TextStyle(  // Estilo del texto.
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(  // Fila que contiene el precio y la puntuación del producto.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Espacio uniforme entre los elementos.
                  children: [
                    Text(  // Muestra el precio del producto.
                      '\$$price',
                      style: TextStyle(  // Estilo del texto del precio.
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,  // Cambia el color del precio a verde.
                      ),
                    ),
                    Row(  // Fila que muestra la puntuación en forma de estrellas.
                      children: [
                        Icon(  // Icono de estrella.
                          Icons.star,
                          color: Colors.orange,  // Cambia el color de la estrella a naranja.
                        ),
                        Text(  // Muestra la puntuación en forma de estrellas.
                          stars,
                          style: TextStyle(  // Estilo del texto de la puntuación.
                            color: Colors.orange,  // Cambia el color de las estrellas a naranja.
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
