import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart'; // Importa el paquete necesario para Flutter.
import 'package:storemap/presentation/containers/cards.dart'; // Importa un contenedor que muestra tarjetas de productos.
import 'package:storemap/presentation/containers/my_appbar.dart';
import 'package:storemap/presentation/screens/categories_screen/accesorios_screen.dart';
import 'package:storemap/presentation/screens/categories_screen/comida_screen.dart';
import 'package:storemap/presentation/screens/categories_screen/ropa_screen.dart'; // Importa un contenedor que representa la barra de la aplicación.

class ProductsScreen extends StatefulWidget {
  // Define la clase ProductsScreen que extiende StatelessWidget.
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final user = FirebaseAuth.instance.currentUser;
  Query db_refe = FirebaseDatabase.instance.ref().child('contacts');

  List<CardType1> products = [];
  Future<void> refreshProducts() async {
    products.clear(); // Limpia la lista de productos
    if (user != null) {
      DatabaseReference dbRef =
          FirebaseDatabase.instance.ref().child('contacts');
      DataSnapshot dataSnapshot;

      dbRef.once().then((event) {
        dataSnapshot = event.snapshot;

        print(dataSnapshot.value);
        if (dataSnapshot.value != null) {
          final data = dataSnapshot.value as Map;
          data.forEach((key, value) {
            print(value['url']);
            final product = CardType1(
              name: value['name'],
              stars: '4.5',
              url: value['url'],
              price: value['price'],
              description: value['description'],
              whatsaap: value['whatsapp'] ?? '0',
            );
            products.add(product);
          });
          print(dataSnapshot.value);

          setState(() {});
        }
      });
    } else {
      print('no');
    }
  }

  @override
  void initState() {
    super.initState();

    refreshProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Define el método 'build' para construir la pantalla.
    return RefreshIndicator(
      onRefresh: refreshProducts,
      child: SafeArea(
        child: Scaffold(
          // Define la estructura básica de la pantalla.
          // appBar: AppBar(
          //   title: const Text('Comidas'),
          // Agrega la barra de la aplicación utilizando el widget MyAppBar.
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
              const SizedBox(
                  height: 20), // Agrega un espacio en blanco vertical.
              Padding(
                padding:
                    const EdgeInsets.all(8.0), // Agrega relleno a su contenido.
                child: Row(
                  // Organiza elementos en una fila horizontal.
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distribuye los elementos de la fila de manera uniforme.
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CategoriesScreen()));
                      },
                      child: const Text('Comida'),
                    ), // Botón "Comida".
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AccesoriosScreen()));
                        },
                        child: const Text('Accesorios')), // Botón "Accesorios".
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => RopaScreen()));
                        },
                        child: const Text('Ropa')), // Botón "Ropa".
                  ],
                ),
              ),
              Expanded(
                // Permite que el ListView ocupe todo el espacio restante disponible.
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return CardType1(
                      name: product.name,
                      stars: product.stars,
                      url: product.url,
                      price: product.price,
                      description: product.description,
                      whatsaap: product.whatsaap,
                    );
                  },
                  // Widget para mostrar una lista de elementos.

                  scrollDirection: Axis
                      .vertical, // Dirección de desplazamiento de la lista (vertical).
                ),
              ),
            ],
          ),
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
