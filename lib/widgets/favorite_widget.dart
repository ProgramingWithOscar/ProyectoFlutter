import 'package:flutter/material.dart';

// Widget FavoriteWidget que muestra una imagen favorita con sombra.

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