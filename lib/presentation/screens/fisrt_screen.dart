import 'package:flutter/material.dart';
import 'package:storemap/database/cards_json.dart';
import 'package:storemap/presentation/containers/cards.dart';
import 'package:storemap/presentation/containers/container_widget.dart';
import 'package:storemap/presentation/containers/my_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        /** Se coloca un scroll vertical de la  pantalla de la aplicacion */
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  /** Guarda el banner incial */
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
                      // Agrega aquí el controlador y lógica de búsqueda si es necesario
                    ),
                  ),
                ],
              ),
              Container(
                height: 200, // Ajusta la altura según tus necesidades.
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Agrega aquí tus elementos deseados
                    ContainerWidget(
                      url: 'assets/images/burguer.jpg',
                      name: 'Burger',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      },
                    ),
                    ContainerWidget(
                      url: 'assets/images/pizza.jpg',
                      name: 'Pizza',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      },
                    ),
                    ContainerWidget(
                      url: 'assets/images/empanada.jpg',
                      name: 'Empanada',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      },
                    ),
                    ContainerWidget(
                      url: 'assets/images/free.jpg',
                      name: 'Burger',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      },
                    ),
                    ContainerWidget(
                      url: 'assets/images/free.jpg',
                      name: 'Burger',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      },
                    ),
                    ContainerWidget(
                      url: 'assets/images/free.jpg',
                      name: 'Burger',
                      onTap: () {
                        _launchURL('https://www.google.com/?hl=es');
                      },
                    ),
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
              // Agrega aquí tu slider de imágenes
              FoodSlider(),
              const SizedBox(
                height: 20,
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ...productosComidasRapidas.map((product) => CardType1(
                      name: product['name'],
                      stars: product['stars'].toString(),
                      url: product['url'],
                      price: product['precio'],))
                ],
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

class FoodSlider extends StatefulWidget {
  @override
  _FoodSliderState createState() => _FoodSliderState();
}

class _FoodSliderState extends State<FoodSlider> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> images = [
    'assets/images/burguer.jpg',
    'assets/images/empanada.jpg',
    'assets/images/pizza.jpg',
  ];

  @override
  void initState() {
    super.initState();
    startAutoPlay();
  }

  void startAutoPlay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      startAutoPlay();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 150,
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.asset(images[index], fit: BoxFit.cover);
              },
            ),
          ),
        ),
      ),
    );
  }
}
