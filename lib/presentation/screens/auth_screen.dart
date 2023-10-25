import 'package:flutter/material.dart';  // Importa el paquete necesario para Flutter.
import 'package:shared_preferences/shared_preferences.dart';  // Importa el paquete para manejar preferencias compartidas.
import 'package:storemap/Comm/comHelper.dart';  // Importa un archivo relacionado con funciones auxiliares.
import 'package:storemap/Comm/genLoginSignupHeader.dart';  // Importa un archivo relacionado con la generación de encabezados para inicio de sesión y registro.
import 'package:storemap/Comm/genTextFormField.dart';  // Importa un archivo relacionado con la generación de campos de texto.
import 'package:storemap/database/database_helper.dart';  // Importa el archivo relacionado con el ayudante de base de datos.
import 'package:storemap/entities/users.dart';  // Importa el archivo relacionado con la entidad de usuario.
import 'package:storemap/presentation/screens/fisrt_screen.dart';  // Importa la pantalla FirstScreen.
import 'package:storemap/presentation/screens/main_screen.dart';  // Importa la pantalla MainScreen.
import 'package:storemap/presentation/screens/register_screen.dart';  // Importa la pantalla RegisterScreen.

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});  // Define la clase LoginPage que extiende StatefulWidget.

  @override
  State<LoginPage> createState() => _LoginPageState();  // Crea el estado para LoginPage.
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();  // Controlador para el campo de correo electrónico.
  final _passwordController = TextEditingController();  // Controlador para el campo de contraseña.
  bool isLoggedIn = false;  // Variable booleana que indica si el usuario ha iniciado sesión.

  @override
  void dispose() {
    _emailController.dispose();  // Libera los recursos del controlador de correo electrónico.
    _passwordController.dispose();  // Libera los recursos del controlador de contraseña.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {  // Define el método 'build' para construir la pantalla.
    return Scaffold(  // Define la estructura básica de la pantalla.
      appBar: AppBar(  // Configura la barra de la aplicación en la parte superior.
        title: Text('Login with Signup'),  // Establece el título de la barra de la aplicación.
      ),
      body: SingleChildScrollView(  // Permite desplazarse en la pantalla cuando el contenido es demasiado largo.
        scrollDirection: Axis.vertical,  // Dirección de desplazamiento vertical.
        child: Container(  // Un contenedor principal que envuelve el contenido.
          child: Center(  // Centra el contenido en la pantalla.
            child: Column(  // Un widget 'Column' que organiza elementos en una columna vertical.
              mainAxisAlignment: MainAxisAlignment.center,  // Alinea los elementos verticalmente al centro.
              children: [  // Lista de elementos en la columna.
                genLoginSignupHeader('Login'),  // Genera un encabezado de inicio de sesión.
                getTextFormField(  // Genera un campo de texto para el correo electrónico.
                    controller: _emailController,
                    icon: Icons.person,
                    hintName: 'User ID'),
                SizedBox(height: 10.0),  // Espacio en blanco vertical de 10 puntos.
                getTextFormField(  // Genera un campo de texto para la contraseña.
                  controller: _passwordController,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,  // Oculta el texto de la contraseña.
                ),
                Container(  // Un contenedor que envuelve el botón de inicio de sesión.
                  margin: EdgeInsets.all(30.0),  // Márgenes del contenedor.
                  width: double.infinity,  // Ancho del contenedor igual al ancho de la pantalla.
                  child: ElevatedButton(  // Botón de inicio de sesión.
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: login,  // Función que se ejecuta al hacer clic en el botón.
                  ),
                  decoration: BoxDecoration(  // Estilo del contenedor del botón.
                    color: Colors.blue,  // Color de fondo del botón.
                    borderRadius: BorderRadius.circular(30.0),  // Radio de borde redondeado.
                  ),
                ),
                Container(  // Un contenedor que envuelve la sección de registro.
                  child: Row(  // Una fila que contiene texto y un botón para registrarse.
                    mainAxisAlignment: MainAxisAlignment.center,  // Alinea los elementos al centro.
                    children: [
                      Text('Does not have account? '),  // Texto informativo.
                      ElevatedButton(  // Botón para ir a la pantalla de registro.
                        child: Text('Signup'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupPage()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {  // Función para iniciar sesión.
    final enteredEmail = _emailController.text;  // Obtiene el correo electrónico ingresado.
    final enteredPassword = _passwordController.text;  // Obtiene la contraseña ingresada.
    final credencialesValidas = await DB.validarCredenciales(enteredEmail, enteredPassword);
    if (credencialesValidas) {  // Comprueba las credenciales.
      setState(() {  // Actualiza el estado de la aplicación.
        isLoggedIn = true;  // Marca al usuario como autenticado.
      });
    } else {
      // Credenciales incorrectas, muestra un diálogo de error.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text(
                'Credenciales incorrectas. Verifica tu correo y contraseña.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }
}


