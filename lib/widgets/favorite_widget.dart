import 'package:flutter/material.dart';

// Widget FavoriteWidget que muestra una imagen favorita con sombra.
class FavoriteWidget extends StatelessWidget {
  final String url;

  // Constructor que toma la URL de la imagen.
  const FavoriteWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Espacio alrededor del widget.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30), // Borde redondeado.
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco del contenedor.
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7), // Sombra con opacidad.
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Image.network(
            url, // Carga una imagen desde una URL.
            fit: BoxFit.cover, // Ajusta la imagen para que cubra el contenedor.
          ),
        ),
      ),
    );
  }
}

// Widget FieldContainer que muestra un campo de formulario con un icono.
class FieldContainer extends StatelessWidget {
  final String labelText; // Texto de etiqueta.
  final String helperText; // Texto de ayuda.
  final Icon icono; // Icono a la izquierda del campo.

  // Constructor que toma labelText, helperText e icono.
  const FieldContainer({
    Key? key,
    required this.labelText,
    required this.helperText,
    required this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true, // Campo de solo lectura.
      enabled: false, // Campo deshabilitado.
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Borde del campo redondeado.
        ),
        icon: icono, // Icono a la izquierda del campo.
        labelText: labelText, // Texto de etiqueta del campo.
        helperText: helperText, // Texto de ayuda del campo.
        filled: true, // Campo relleno.
      ),
    );
  }
}

