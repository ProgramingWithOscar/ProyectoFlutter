import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storemap/Comm/comHelper.dart';
import 'package:storemap/Comm/genLoginSignupHeader.dart';
import 'package:storemap/Comm/genTextFormField.dart';
import 'package:storemap/database/database_helper.dart';
import 'package:storemap/entities/users.dart';
import 'package:storemap/presentation/screens/fisrt_screen.dart';
import 'package:storemap/presentation/screens/main_screen.dart';
import 'package:storemap/presentation/screens/register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoggedIn =
      false; // Variable booleana que indica si el usuario ha iniciado sesión.

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignupHeader('Login'),
                getTextFormField(
                    controller: _emailController,
                    icon: Icons.person,
                    hintName: 'User ID'),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: login,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Does not have account? '),
                      ElevatedButton(
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

  void login() async {
    // Función para iniciar sesión.
    final enteredEmail =
        _emailController.text; // Obtiene el correo electrónico ingresado.
    final enteredPassword =
        _passwordController.text; // Obtiene la contraseña ingresada.
    final credencialesValidas =
        await DB.validarCredenciales(enteredEmail, enteredPassword);
    if (credencialesValidas) {
      // Comprueba las credenciales.
      setState(() {
        // Actualiza el estado de la aplicación.
        isLoggedIn = true; // Marca al usuario como autenticado.
      });
    } else {
      // Credenciales incorrectas, muestra un diálogo de error.
      // ignore: use_build_context_synchronously
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
