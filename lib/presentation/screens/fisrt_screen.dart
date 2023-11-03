import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:storemap/database/cards_json.dart';
import 'package:storemap/presentation/containers/cards.dart';
import 'package:storemap/presentation/containers/container_widget.dart';
import 'package:storemap/presentation/containers/my_appbar.dart';
import 'package:storemap/presentation/slider/food_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<CardType1> products = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/279.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'pollo asado',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...productosComidasRapidas.map((product) => ContainerWidget(
                          url: product['url'].toString(),
                          name: product['name'],
                          onTap: () {
                            _launchURL('https://www.google.com/?hl=es');
                          },
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '!Promos especiales¡',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              FoodSlider(),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: products.map((product) {
                  return CardType1(
                    name: product.name,
                    stars: product.stars,
                    url: product.url,
                    price: product.price,
                    description: product.description,
                    whatsaap: product.whatsaap ??  '0',
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }
}
