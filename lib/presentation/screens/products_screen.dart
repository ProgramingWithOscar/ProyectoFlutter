import 'package:flutter/material.dart'; // Importa el paquete necesario para Flutter.
import 'package:storemap/database/cards_json.dart'; // Importa un archivo que contiene datos de productos.
import 'package:storemap/presentation/containers/cards.dart'; // Importa un contenedor que muestra tarjetas de productos.
import 'package:storemap/presentation/containers/my_appbar.dart'; // Importa un contenedor que representa la barra de la aplicación.

class ProductsScreen extends StatelessWidget {
  // Define la clase ProductsScreen que extiende StatelessWidget.
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define el método 'build' para construir la pantalla.
    return SafeArea(
      // Asegura que el contenido no se coloque debajo de las barras de sistema.
      child: Scaffold(
        // Define la estructura básica de la pantalla.
        // appBar:
        //     MyAppBar(), // Agrega la barra de la aplicación utilizando el widget MyAppBar.
        body: Column(
          // Organiza el contenido en una columna vertical.
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0), // Agrega relleno a su contenido.
              child: ContainerWidget(
                  url:
                      'https://images.pexels.com/photos/15818982/pexels-photo-15818982/free-photo-of-mano-comida-fotografia-de-comida-espacio-para-texto.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  fi: BoxFit
                      .cover), // Muestra un contenedor de imagen con una URL.
            ),
            const SizedBox(height: 20), // Agrega un espacio en blanco vertical.
            Padding(
              padding:
                  const EdgeInsets.all(8.0), // Agrega relleno a su contenido.
              child: Row(
                // Organiza elementos en una fila horizontal.
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Distribuye los elementos de la fila de manera uniforme.
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Comida'),
                  ), // Botón "Comida".
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('Accesorios')), // Botón "Accesorios".
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('Ropa')), // Botón "Ropa".
                ],
              ),
            ),
            Expanded(
              // Permite que el ListView ocupe todo el espacio restante disponible.
              child: ListView(
                // Widget para mostrar una lista de elementos.
                children: [
                  ...productosComidasRapidas.map((product) => CardType1(
                        name: product['name'],
                        stars: product['stars'].toString(),
                        url: product['url'],
                        price: product['precio'],
                      )) // Mapea los datos de productos y crea tarjetas CardType1.
                ],
                scrollDirection: Axis
                    .vertical, // Dirección de desplazamiento de la lista (vertical).
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  // Define la clase ContainerWidget que extiende StatelessWidget.
  final String url; // URL de la imagen.
  final BoxFit fi; // Ajuste de la imagen.

  const ContainerWidget({super.key, required this.url, required this.fi});

  @override
  Widget build(BuildContext context) {
    // Define el método 'build' para construir el contenedor.
    return ClipRRect(
      // Aplica esquinas redondeadas al contenido.
      borderRadius:
          BorderRadius.circular(20), // Radio de las esquinas redondeadas.
      child: Container(
        // Contenedor que muestra la imagen.
        color: Colors.black, // Color de fondo del contenedor.
        width: MediaQuery.of(context)
            .size
            .width, // Ancho del contenedor (ancho de la pantalla).
        height: 200, // Altura del contenedor.
        child: Image.network(
          // Muestra una imagen desde una URL.
          url, // URL de la imagen.
          fit: fi, // Ajuste de la imagen.
        ),
      ),
    );
  }
}
