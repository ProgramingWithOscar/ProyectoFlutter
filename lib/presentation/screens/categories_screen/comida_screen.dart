import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart'; // Importa el paquete necesario para Flutter.
import 'package:storemap/presentation/containers/cards.dart'; // Importa un contenedor que muestra tarjetas de productos.
import 'package:storemap/presentation/containers/my_appbar.dart'; // Importa un contenedor que representa la barra de la aplicación.

class CategoriesScreen extends StatefulWidget {
  // Define la clase ProductsScreen que extiende StatelessWidget.
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isLoading = true;
  final user = FirebaseAuth.instance.currentUser;
  Query db_refe = FirebaseDatabase.instance.ref().child('contacts');

  List<CardType1> products = [];
  Future<void> refreshProducts() async {
   
    setState(() {
      isLoading = true;
    });
     await Future.delayed(Duration(seconds: 2));
    
     products.clear(); // Limpia la lista de productos
    if (user != null) {
      DatabaseReference dbRef =
          FirebaseDatabase.instance.ref().child('contacts');
      DataSnapshot dataSnapshot;

      dbRef.orderByChild('category').equalTo('Comida').once().then((event) {
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

          setState(() {
            isLoading = false;
          });
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
            appBar: AppBar(title: const Text('Comida')),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber[900],
                    ),
                  )
                : ListView.builder(
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
          //       ],
          //     ),
          //   ),
          // ),
        ));
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
