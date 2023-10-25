import 'package:flutter/material.dart';
//no se esta usando aun
class ProductDetailsScreen extends StatelessWidget {
  final String name;
  final String stars;
  final String url;
  final String price;

  ProductDetailsScreen({
    required this.name,
    required this.stars,
    required this.url,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(url),
            Text('Name: $name'),
            Text('Stars: $stars'),
            Text('Price: \$${price}'),
            // Add more details here
          ],
        ),
      ),
    );
  }
}
