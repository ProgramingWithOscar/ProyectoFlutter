import 'package:flutter/material.dart';

// Define una clase llamada 'genLoginSignupHeader' que extiende StatelessWidget.
class genLoginSignupHeader extends StatelessWidget {
  String headerName; // Declaración de una variable que almacena el nombre del encabezado.

  // Constructor de la clase 'genLoginSignupHeader' que recibe un argumento 'headerName'.
  genLoginSignupHeader(this.headerName);

  // Override del método 'build' de StatelessWidget para construir el widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50.0), // Espacio en blanco vertical de 50 unidades.
          Text(
            headerName, // Muestra el 'headerName' pasado como argumento.
            style: TextStyle(
                fontWeight: FontWeight.bold, // Estilo de fuente en negrita.
                color: Colors.black, // Color de texto negro.
                fontSize: 40.0), // Tamaño de fuente de 40 unidades.
          ),
          SizedBox(height: 10.0), // Espacio en blanco vertical de 10 unidades.
          Image.asset(
            "assets/images/logo.png", // Carga una imagen desde un archivo en el proyecto.
            height: 150.0, // Altura de la imagen de 150 unidades.
            width: 150.0, // Ancho de la imagen de 150 unidades.
          ),
          SizedBox(height: 10.0), // Espacio en blanco vertical de 10 unidades.
          Text(
            'Sample Code', // Muestra el texto 'Sample Code'.
            style: TextStyle(
                fontWeight: FontWeight.bold, // Estilo de fuente en negrita.
                color: Colors.black38, // Color de texto negro con opacidad.
                fontSize: 25.0), // Tamaño de fuente de 25 unidades.
          ),
          SizedBox(height: 10.0), // Espacio en blanco vertical de 10 unidades.
        ],
      ),
    );
  }
}
