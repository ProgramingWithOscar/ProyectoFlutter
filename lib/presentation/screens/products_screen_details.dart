import 'package:flutter/material.dart';
import 'package:storemap/presentation/containers/bottom_navigator.dart';
import 'package:storemap/theme/app_theme.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String description;
  final String stars;

  const ProductsDetailsScreen(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.description,
      required this.stars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
          label: const Text('Comprar en WhatsApp', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold
          ),),
          onPressed: () {},
          icon: const Icon(Icons.call_made, color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
                child: _Product(
              url: imageUrl,
              name: name,
              description: description,
              price: price,
              stars: stars,
            )),
            Positioned(
              left: 10,
              top: 45,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300], // Color de fondo gris claro
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Product extends StatelessWidget {
  final String url;
  final String name;
  final String description;
  final String price;
  final String stars;
  const _Product({
    super.key,
    required this.url,
    required this.name,
    required this.description,
    required this.price,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 300,
        width: double.infinity,
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.star_border_outlined,
                    color: Colors.amber[900],
                  ),
                  label: Text(
                    stars,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber[900]),
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  description,
                  style: TextStyle(fontSize: 13),
                )),
            const SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '\$$price',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.amber[900],
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      )
    ]);
  }
}
