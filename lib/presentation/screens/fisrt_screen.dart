import 'package:flutter/material.dart';
import 'package:storemap/presentation/containers/container_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class FisrtScreen extends StatelessWidget {
  const FisrtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(2),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Nuevos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Expanded(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ContainerWidget(
                      url: 'assets/images/burguer.jpg',
                      name: 'Burguer',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      }),
                  ContainerWidget(
                      url: 'assets/images/pizza.jpg',
                      name: 'Pizza',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      }),
                  ContainerWidget(
                      url: 'assets/images/empanada.jpg',
                      name: 'Empanada',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      }),
                  ContainerWidget(
                      url: 'assets/images/free.jpg',
                      name: 'Burguer',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      }),
                  ContainerWidget(
                      url: 'assets/images/free.jpg',
                      name: 'Burguer',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      }),
                  ContainerWidget(
                      url: 'assets/images/free.jpg',
                      name: 'Burguer',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Top 🎊',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                ContainerWidget(
                    url: 'assets/images/burguer.jpg',
                    name: 'Burguer',
                    onTap: () {
                      _launchURL('https://www.google.com/?hl=es');
                    }),
                ContainerWidget(
                    url: 'assets/images/pizza.jpg',
                    name: 'Pizza',
                    onTap: () {
                      _launchURL('https://www.google.com/?hl=es');
                    }),
                ContainerWidget(
                    url: 'assets/images/empanada.jpg',
                    name: 'Empanada',
                    onTap: () {
                      _launchURL('https://www.google.com/?hl=es');
                    }),
                ContainerWidget(
                    url: 'assets/images/free.jpg',
                    name: 'Burguer',
                    onTap: () {
                      _launchURL('https://www.google.com/?hl=es');
                    }),
                ContainerWidget(
                    url: 'assets/images/free.jpg',
                    name: 'Burguer',
                    onTap: () {
                      _launchURL('https://www.google.com/?hl=es');
                    }),
                ContainerWidget(
                    url: 'assets/images/free.jpg',
                    name: 'Burguer',
                    onTap: () {
                      _launchURL('https://www.google.com/?hl=es');
                    }),
              ],
            ),
          ),
        ],
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
