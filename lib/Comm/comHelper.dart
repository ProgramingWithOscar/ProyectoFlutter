// Importa las bibliotecas necesarias para Flutter y la biblioteca Toast.
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// Define una función llamada 'alertDialog' que muestra un mensaje emergente de tipo "toast".
// Recibe dos argumentos: 'context' y 'msg'.
void alertDialog(BuildContext context, String msg) {
  // Utiliza la biblioteca Toast para mostrar el mensaje 'msg' con una duración larga y gravedad en la parte inferior.
  Toast.show(msg, duration: Toast.lengthLong, gravity: Toast.bottom);
}

// Define una función llamada 'validateEmail' para validar si una cadena 'email' es una dirección de correo electrónico válida.
bool validateEmail(String email) {
  // Crea una expresión regular (RegExp) para validar el formato del correo electrónico.
  final emailReg = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  // Utiliza el método 'hasMatch' de la expresión regular para verificar si 'email' coincide con el patrón.
  return emailReg.hasMatch(email);
}

