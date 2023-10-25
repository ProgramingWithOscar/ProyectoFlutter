import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class FoodSlider extends StatelessWidget {
  final List<String> images = [
    'assets/images/burguer.jpg',
    'assets/images/empanada.jpg',
    'assets/images/pizza.jpg',
  ];

  FoodSlider({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        itemCount: images.length,
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        autoplayDelay: 3000, // 3000 ms = 3 segundos
        itemBuilder: (context, index) {
          return _Slide(imageUrl: images[index]);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String imageUrl;

  _Slide({Key? key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 150,
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
