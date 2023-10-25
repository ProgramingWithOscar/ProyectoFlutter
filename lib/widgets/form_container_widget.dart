import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  // Define los parámetros que se pueden proporcionar al widget
  final TextEditingController? controller; // Controlador para el campo de texto
  final Key? fieldKey; // Clave para el campo
  final bool? isPasswordField; // Un indicador si el campo es de contraseña
  final String? hintText; // Texto de sugerencia en el campo
  final String? labelText; // Etiqueta del campo
  final String? helperText; // Texto de ayuda para el campo
  final FormFieldSetter<String>? onSaved; // Callback para guardar el valor
  final FormFieldValidator<String>? validator; // Validador personalizado
  final ValueChanged<String>? onFieldSubmitted; // Callback cuando se envía el campo
  final TextInputType? inputType; // Tipo de entrada (número, texto, etc.)

  const FormContainerWidget({
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
  });

  @override
  _FormContainerWidgetState createState() => new _FormContainerWidgetState();
}


class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true; // Un indicador para ocultar/mostrar la contraseña

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35), // Configura el color de fondo del contenedor
        borderRadius: BorderRadius.circular(10), // Establece bordes redondeados
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black), // Establece el color del texto
        controller: widget.controller, // Asigna el controlador del campo de texto
        keyboardType: widget.inputType, // Configura el tipo de entrada (número, texto, etc.)
        key: widget.fieldKey, // Asigna la clave del campo
        obscureText: widget.isPasswordField == true ? _obscureText : false, // Configura el modo de contraseña si es necesario
        onSaved: widget.onSaved, // Callback para guardar el valor
        validator: widget.validator, // Validador personalizado
        onFieldSubmitted: widget.onFieldSubmitted, // Callback cuando se envía el campo
        decoration: InputDecoration(
          border: InputBorder.none, // Elimina el borde del campo
          filled: true, // Rellena el campo
          hintText: widget.hintText, // Configura el texto de sugerencia
          hintStyle: const TextStyle(color: Colors.black45), // Configura el estilo del texto de sugerencia
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText; // Cambia la visibilidad de la contraseña
              });
            },
            child: widget.isPasswordField == true
                ? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false ? Colors.blue : Colors.grey,)
                : const Text(""),
          ),
        ),
      ),
    );
  }
}
