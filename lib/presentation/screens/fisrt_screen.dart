import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:storemap/functions/functions.dart';
import 'package:storemap/presentation/containers/cards.dart';
import 'package:storemap/presentation/containers/container_widget.dart';
import 'package:storemap/presentation/containers/my_appbar.dart';
import 'package:storemap/presentation/screens/page_principal.dart';
import 'package:storemap/presentation/screens/skelots/container_widget_skeleton.dart';
import 'package:storemap/presentation/slider/food_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<CardType1> products = [];
  List<CardType1> filteredProducts = [];
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  bool showProductList = false;
  int maxDisplayedProducts = 4; // Máximo de productos a mostrar

  Future<void> refreshProducts() async {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3));

    products.clear(); // Limpia la lista de productos
    if (user != null) {
      DatabaseReference dbRef =
          FirebaseDatabase.instance.ref().child('contacts');
      DataSnapshot dataSnapshot;

      dbRef.once().then((event) {
        dataSnapshot = event.snapshot;

        if (dataSnapshot.value != null) {
          final data = dataSnapshot.value as Map;
          data.forEach((key, value) {
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

  void filterProducts(String query) {
    final filtered = products
        .where((product) =>
            product.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredProducts = filtered.take(maxDisplayedProducts).toList();
      showProductList = query.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshProducts,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    PagePrincipal(
                      isLoading: isLoading,
                      products: products,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: TextField(
                              controller: searchController,
                              decoration: const InputDecoration(
                                hintText: "Buscar",
                                filled: true,
                              ),
                              style: const TextStyle(color: Colors.black),
                              onChanged: (query) {
                                if (query.isEmpty) {
                                  setState(() {
                                    filteredProducts.clear();
                                    showProductList = false;
                                  });
                                } else {
                                  filterProducts(query);
                                }
                              },
                            ),
                          ),
                          if (showProductList)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.white, // Fondo blanco de la lista
                                height: filteredProducts.isEmpty ? 100 : 200,
                                child: filteredProducts.isEmpty
                                    ? const Center(
                                        child: Text(
                                          'No hay coincidencias con tu búsqueda',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : ListView(
                                        children:
                                            filteredProducts.map((product) {
                                          return Card(
                                            elevation:
                                                3, // Controla la sombra del card
                                            margin: const EdgeInsets.all(
                                                8), // Controla el margen entre los cards
                                            child: ListTile(
                                              leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: Image.network(
                                                    product.url,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              subtitle: Text(
                                                  product.description!,
                                                  maxLines: 2),
                                              trailing: Text(
                                                product.price!,
                                                style: TextStyle(
                                                    color: Colors.amber[900]),
                                              ),
                                              title: Text(product.name!),
                                              onTap: () {
                                                openWhatsApp(product.whatsaap!);
                                              },
                                            ),
                                          );
                                        }).toList(),
                                      ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

