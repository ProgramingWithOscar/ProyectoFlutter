import 'package:flutter/material.dart';
import 'package:storemap/database/cards_json.dart';
import 'package:storemap/presentation/containers/cards.dart';
import 'package:storemap/presentation/containers/container_widget.dart';
import 'package:storemap/presentation/containers/my_appbar.dart';
import 'package:storemap/presentation/slider/food_slider.dart';
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
                    ...productosComidasRapidas.map((product) => ContainerWidget(
                      url: product['url'].toString(), 
                      name: product['name'], 
                          onTap: () {//me redirecciona a otra pagina o info del producto 
                        _launchURL('https://www.google.com/?hl=es');
                      },))
                    // Agrega aquí tus elementos deseados
                    // ContainerWidget(//widget personalizado y llena el constructor
                    //   url: 'assets/images/burguer.jpg',
                    //   name: 'Burger',
                      // onTap: () {//me redirecciona a otra pagina o info del producto 
                      //   _launchURL('https://www.google.com/?hl=es');
                      // },
                    // ),
                    // ContainerWidget(
                    //   url: 'assets/images/pizza.jpg',
                    //   name: 'Pizza',
                    //   onTap: () {
                    //     _launchURL('https://www.google.com/?hl=es');
                    //   },
                    // ),
                    // ContainerWidget(
                    //   url: 'assets/images/empanada.jpg',
                    //   name: 'Empanada',
                    //   onTap: () {
                    //     _launchURL('https://www.google.com/?hl=es');
                    //   },
                    // ),
                    // ContainerWidget(
                    //   url: 'assets/images/free.jpg',
                    //   name: 'Burger',
                    //   onTap: () {
                    //     _launchURL('https://www.google.com/?hl=es');
                    //   },
                    // ),
                    // ContainerWidget(
                    //   url: 'assets/images/free.jpg',
                    //   name: 'Burger',
                    //   onTap: () {
                    //     _launchURL('https://www.google.com/?hl=es');
                    //   },
                    // ),
                    // ContainerWidget(
                    //   url: 'assets/images/free.jpg',
                    //   name: 'Burger',
                    //   onTap: () {
                    //     _launchURL('https://www.google.com/?hl=es');
                    //   },
                    // ),
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
                      url: product['url'].toString(),
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


