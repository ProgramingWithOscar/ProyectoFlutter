import 'package:flutter/material.dart';

class CardType1 extends StatelessWidget {
  final String name;
  final String stars;
  final String url;
  final String price;

  const CardType1({
    required this.name,
    required this.stars,
    required this.url,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              image: DecorationImage(
                image: NetworkImage('https://media.istockphoto.com/id/1448322070/es/foto/sabrosa-hamburguesa-fresca-en-mesa-de-madera.jpg?s=1024x1024&w=is&k=20&c=lQH4UE7iWQv_i8PyeupRFoBkuUu3BrJvYjCkQGOnIcA='),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$$price',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Cambia el color del precio.
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange, // Cambia el color de la estrella.
                        ),
                        Text(
                          stars,
                          style: TextStyle(
                            color: Colors.orange, // Cambia el color de las estrellas.
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

