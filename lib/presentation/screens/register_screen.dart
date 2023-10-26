import 'package:flutter/material.dart';

// Importaciones de módulos y clases personalizadas.
import 'package:storemap/Comm/genLoginSignupHeader.dart';
import 'package:storemap/Comm/genTextFormField.dart';
import 'package:storemap/database/database_helper.dart';
import 'package:storemap/entities/users.dart';

class SignupPage extends StatefulWidget {
  // Constructor para el widget SignupPage.
  const SignupPage({super.key});

  @override
  // Crea un estado para SignupPage.
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Función para mostrar usuarios registrados en el futuro.
  Future<void> mostrarUsuariosRegistrados() async {
    // Obtiene una lista de UserModel desde la base de datos.
    final List<UserModel> usuarios = await DB.getUsers();
    for (final usuario in usuarios) {
      // Imprime la información del usuario.
      print('id: ${usuario.id}, name: ${usuario.name}, email: ${usuario.email}');
    }
  }

  // Clave global para validar el formulario.
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para campos de entrada.
  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();

  // Lista para almacenar UserModel.
  List<UserModel> users = [];

  @override
  void dispose() {
    _conUserId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión con Registro'),
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
                  // Muestra un encabezado de registro.
                  genLoginSignupHeader(headerName: 'Registro', height: 180, width: 180,),

    

                  const SizedBox(height: 10.0),

                  // Crea un campo de formulario de texto para el nombre de usuario.
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'Nombre de Usuario'),

                  const SizedBox(height: 10.0),

                  // Crea un campo de formulario de texto para el correo electrónico.
                  getTextFormField(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Correo Electrónico'),

                  const SizedBox(height: 10.0),

                  // Crea un campo de formulario de texto para la contraseña.
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Contraseña',
                    isObscureText: true,
                  ),

                  const SizedBox(height: 10.0),

                  // Crea un campo de formulario de texto para confirmar la contraseña.
                  getTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Confirmar Contraseña',
                    isObscureText: true,
                  ),

                  // Contenedor para el botón de registro.
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
                        'Registrarse',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  // Fila con un enlace para iniciar sesión.
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('¿Ya tienes una cuenta? '),
                    ElevatedButton(
                      child: const Text('Iniciar Sesión'),
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
