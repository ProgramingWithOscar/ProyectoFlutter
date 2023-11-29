import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class FoodSlider extends StatelessWidget {
  // Lista de rutas a imágenes que se mostrarán en el control deslizante
  final List<String> images = [
    'assets/images/1_poster.jpg',
    'assets/images/2_poster.jpg',
    'assets/images/3_poster.jpg',
  ];

  // Constructor de la clase FoodSlider
  FoodSlider({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210, // Altura del control deslizante
      width: double.infinity, // Ancho a lo largo de toda la pantalla
      child: Swiper(
        itemCount: images.length, // Cantidad de elementos en el control deslizante
        viewportFraction: 0.8, // Fracción de la pantalla visible por elemento
        scale: 0.9, // Escala de reducción de elementos
        autoplay: true, // Reproducción automática del control deslizante
        autoplayDelay: 3000, // Retardo entre diapositivas (3000 ms = 3 segundos)
        itemBuilder: (context, index) {
          // Constructor de elementos del control deslizante
          return _Slide(imageUrl: images[index]);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String imageUrl; // Ruta a la imagen para esta diapositiva

  // Constructor de la clase _Slide
  _Slide({Key? key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30), // Espaciado en la parte inferior
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
          boxShadow: const [
            BoxShadow(
              color: Colors.black45, // Color de la sombra
              blurRadius: 10, // Radio de desenfoque
              offset: Offset(0, 10), // Desplazamiento de la sombra
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
          child: SizedBox(
            height: 150, // Altura de la imagen
            child: Image.asset(imageUrl, fit: BoxFit.cover), // Imagen desde la ruta
          ),
        ),
      ),
    );
  }
}

