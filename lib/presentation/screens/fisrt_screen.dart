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
          scrollDirection: Axis.vertical,//direccion del scroll
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,//aliniar el scrool y que inicia desde start
            children: [
              Stack(//permite poner widget uno encima del otro en este caso la barra de busqueda (text field)
                alignment: AlignmentDirectional.topCenter,
                children: [
                  /** Guarda el banner incial */
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/279.png'),
                        fit: BoxFit.cover,//imagen se adapte al conteiner y no se distorcione
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(//barra de busqueda 
                      decoration: InputDecoration(//decoracion de barra de busqueda
                        filled: true,//relleno gris (color de fondo)
                        hintText: 'pollo asado',//placeholder(html)
                        border: OutlineInputBorder(//borde de la barra
                          borderRadius: BorderRadius.circular(20),
                        ),
                        prefixIcon: const Icon(Icons.search),//icono de busqyeda y prefix para que este dentro de la caja
                      ),
                      // Agrega aquí el controlador y lógica de búsqueda si es necesario
                    ),
                  ),
                ],
              ),
              Container(
                height: 200, // Ajusta la altura según tus necesidades.
                child: ListView(//mostrar lista de img
                  scrollDirection: Axis.horizontal,//axis es la clase 
                  children: [
                    // Agrega aquí tus elementos deseados
                    ContainerWidget(//widget personalizado y llena el constructor
                      url: 'assets/images/burguer.jpg',
                      name: 'Burger',
                      onTap: () {//me redirecciona a otra pagina o info del producto 
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
                physics: NeverScrollableScrollPhysics(),//no deja que el usuario haga scroll
                shrinkWrap: true,//se adapta al espacio total del widget
                children: [
                  /**
                   * Aca se trae el JSON de comidas rapidas y se mapea, generando
                   * una tarjeta por cada producto del JSON
                   */
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

  Future<void> _launchURL(String url) async {//promesas 
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

 /// Lista de imagenes para el slider
  List<String> images = [
    'assets/images/burguer.jpg',
    'assets/images/empanada.jpg',
    'assets/images/pizza.jpg',
  ];

  @override
  //inicializamos el estado del slider 
  void initState() {
    super.initState();
    startAutoPlay();
  }


  /// esta funcion lo que establece es un Future que nos
  /// permite colocar una duracion para el cambio de las imagenes
  void startAutoPlay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        
        _currentPage = 0;
      }
      // animar las imagenes(pasar solas las img)
      _pageController.animateToPage(
        _currentPage,
        duration:const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      startAutoPlay();
    });
  }

  @override
  // limpia los controladores
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),//poner un padding
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 2,//grosor del borde
              blurRadius: 9,//difuminacion
              offset: const Offset(0, 0),//espacio de cuando se renderise
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 150,
            child: PageView.builder(//buider se construye en tiempo en ejecucion o peticion
              controller: _pageController,//
              itemCount: images.length,//tamaño de la lista
              itemBuilder: (context, index) {//posicion de la list 
                return Image.asset(images[index], fit: BoxFit.cover);//retorna la imagen dependiendo de la peticion
              },
            ),
          ),
        ),
      ),
    );
  }
}
