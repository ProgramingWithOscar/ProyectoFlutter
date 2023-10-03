import 'package:flutter/material.dart';
import 'package:storemap/presentation/screens/main_screen.dart';

class AuthScreen extends StatefulWidget {
  // Define una clase llamada AuthScreen que extiende StatefulWidget.
  @override
  _AuthScreenState createState() =>
      _AuthScreenState(); // Crea el estado para AuthScreen.
}

class _AuthScreenState extends State<AuthScreen> {
  // Define el estado de AuthScreen.
  TextEditingController emailController =
      TextEditingController(); // Controlador para el campo de correo electrónico.
  TextEditingController passwordController =
      TextEditingController(); // Controlador para el campo de contraseña.
  bool isRegistered =
      false; // Variable booleana que indica si el usuario está registrado.
  bool isLoggedIn =
      false; // Variable booleana que indica si el usuario ha iniciado sesión.
  String? registeredEmail; // Almacena el correo electrónico registrado.
  String? registeredPassword; // Almacena la contraseña registrada.
  String? nameRegistred;
  void register() async {
    // Función para registrar un usuario.
    final result = await Navigator.pushNamed(context,
        '/register'); // Abre la pantalla de registro y espera un resultado.
    if (result != null && result is Map<String, String>) {
      // Comprueba si se recibió un resultado válido.
      setState(() {
        // Actualiza el estado de la aplicación.
        isRegistered = true;
        registeredEmail =
            result['email']; // Almacena el correo electrónico registrado.
        registeredPassword =
            result['password']; // Almacena la contraseña registrada.
        nameRegistred = result['name']; //Almacena el nombre registrado
      });
    }
  }

  void login() async {
    // Función para iniciar sesión.
    if (isRegistered) {
      // Comprueba si el usuario está registrado.
      final enteredEmail =
          emailController.text; // Obtiene el correo electrónico ingresado.
      final enteredPassword =
          passwordController.text; // Obtiene la contraseña ingresada.

      if (enteredEmail == registeredEmail &&
          enteredPassword == registeredPassword) {
        // Comprueba las credenciales.
        setState(() {
          // Actualiza el estado de la aplicación.
          isLoggedIn = true; // Marca al usuario como autenticado.
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
    } else {
      // El usuario no está registrado, muestra un diálogo de error.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text('Debes registrarte antes de iniciar sesión.'),
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

  @override
  Widget build(BuildContext context) {
    // Método para construir la interfaz de AuthScreen.
    if (isLoggedIn) {
      // Si el usuario ha iniciado sesión, muestra la pantalla HelloWorldScreen.
      return MainScreen();
    } else {
      // Si no ha iniciado sesión, muestra la pantalla de inicio de sesión o registro.
      return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'Inicio de Sesión o Registro',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/logo.jpg', height: 300),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Correo Electrónico'),
                ),
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true, // Oculta el texto de la contraseña.
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: login, // Llama a la función de inicio de sesión.
                child: Text('Iniciar Sesión'),
              ),
              SizedBox(height: 50),
              TextButton(
                onPressed: register, // Llama a la función de registro.
                child: Text('¿No tienes una cuenta? Regístrate aquí.'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
