
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElasticInDown(
          
          duration: const Duration(seconds: 2),
          child: Image.asset('assets/images/logo-storemap.jpg')), // Reemplaza 'assets/logo.png' con la ruta de tu logotipo.
      ),
    );
  }
}
