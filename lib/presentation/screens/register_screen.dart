import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List<String> rol = ["Emprendedor", "Comprador"];

  String? selectedRol;

  // Define una clase llamada RegisterScreen que extiende StatelessWidget.
  @override
  Widget build(BuildContext context) {
    // Método para construir la interfaz de RegisterScreen.
    TextEditingController registerEmailController =
        TextEditingController(); // Controlador para el correo electrónico de registro.
    TextEditingController registerPasswordController =
        TextEditingController(); // Controlador para la contraseña de registro.
    TextEditingController registerUserController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/register.png',
              height: 100,
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: registerUserController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: registerEmailController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: registerPasswordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true, // Oculta el texto de la contraseña.
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Rol de usuario:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
                width: 250,
                child: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      selectedRol = value;
                    });
                  },
                  value: selectedRol,
                  items: rol.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final registerEmail = registerEmailController
                    .text; // Obtiene el correo electrónico ingresado.
                final registerPassword = registerPasswordController.text;
                final registerName = registerUserController.text;
                // Obtiene la contraseña ingresada.
                // Cierra la pantalla de registro y devuelve los datos al estado anterior.
                if (registerEmail != '' &&
                    registerPassword != '' &&
                    registerName != '' && selectedRol != '') {
                  final result = {
                    'email': registerEmail,
                    'password': registerPassword,
                    'name': registerName,
                    'rol': selectedRol
                  }; // Crea un mapa con los datos de registro.
                  Navigator.pop(context, result);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Campos vacios'),
                        content: const Text(
                            'Debe llenar todos los campos, intente nuevamente'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
