import 'package:flutter/material.dart';

import 'package:storemap/Comm/genLoginSignupHeader.dart';
import 'package:storemap/Comm/genTextFormField.dart';
import 'package:storemap/database/database_helper.dart';
import 'package:storemap/entities/users.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Future<void> mostrarUsuariosRegistrados() async {
    final List<UserModel> usuarios = await DB.getUsers();
    for (final usuario in usuarios) {
      print(
          'id: ${usuario.id}, name: ${usuario.name}, email: ${usuario.email}');
    }
  }

  final _formKey = GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();

  List<UserModel> users = [];

  @override
  void dispose() {
    _conUserId.dispose();

    super.dispose();
  }
  // ignore: prefer_typing_uninitialized_variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Signup'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Signup'),
                  getTextFormField(
                      controller: _conUserId,
                      icon: Icons.person,
                      hintName: 'User ID'),
                  const SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'User Name'),
                  const SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  const SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  const SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        final nameEntered = _conUserName.text;
                        final registerEmail = _conEmail.text;
                        // Obtiene el correo electrónico ingresado.
                        final registerPassword = _conPassword.text;
                        // Obtiene la contraseña ingresada.
                        final usuario = UserModel(
                            name: nameEntered,
                            email: registerEmail,
                            password: registerPassword);
                        final insertedRows = await DB.insert(usuario);
                        if (insertedRows > 0) {
                          Navigator.pop(context,
                              usuario); // Cierra la pantalla de registro y devuelve los datos al estado anterior.
                          mostrarUsuariosRegistrados();
                        } else {
                          // Error: no se pudo insertar el usuario en la base de datos.
                          // Puedes mostrar un mensaje de error al usuario.
                        }
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Does you have account? '),
                    ElevatedButton(
                      child: const Text('Sign In'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
