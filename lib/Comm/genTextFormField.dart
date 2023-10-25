import 'package:flutter/material.dart';
import 'comHelper.dart'; // Importa la biblioteca 'comHelper.dart'.

// Define una clase llamada 'getTextFormField' que extiende StatelessWidget.
class getTextFormField extends StatelessWidget {
  TextEditingController controller; // Declara un controlador para el campo de texto.
  String hintName; // Declara el texto de sugerencia (placeholder) para el campo de texto.
  IconData icon; // Declara el icono que se muestra junto al campo de texto.
  bool isObscureText; // Indica si el texto en el campo de texto debe ser ocultado (por defecto, es falso).
  TextInputType inputType; // Define el tipo de entrada del campo de texto (por defecto, es TextInputType.text).
  bool isEnable; // Indica si el campo de texto está habilitado (por defecto, es verdadero).

  // Constructor de la clase 'getTextFormField' que recibe varios argumentos.
  getTextFormField(
      {required this.controller,
      required this.hintName,
      required this.icon,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.isEnable = true});

  // Override del método 'build' de StatelessWidget para construir el widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0), // Agrega un relleno horizontal al contenedor.
      child: TextFormField(
        controller: controller, // Asigna el controlador al campo de texto.
        obscureText: isObscureText, // Configura si el texto debe ocultarse.
        enabled: isEnable, // Configura si el campo de texto está habilitado.
        keyboardType: inputType, // Configura el tipo de entrada del campo de texto.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintName';
          }
          if (hintName == "Email" && !validateEmail(value)) {
            return 'Please Enter Valid Email';
          }
          return null;
        },
        // Configura la validación del campo de texto y cómo se muestra el error.
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(icon), // Agrega un icono como prefijo al campo de texto.
          hintText: hintName, // Establece el texto de sugerencia (placeholder) del campo de texto.
          labelText: hintName, // Etiqueta del campo de texto.
          fillColor: Colors.grey[200], // Configura el color de fondo del campo de texto.
          filled: true, // Establece si se rellena el campo de texto.
        ),
      ),
    );
  }
}
