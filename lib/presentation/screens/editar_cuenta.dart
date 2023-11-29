import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditarCuentaScreen extends StatefulWidget {
  const EditarCuentaScreen({Key? key});

  @override
  State<EditarCuentaScreen> createState() => _EditarCuentaScreenState();
}

class _EditarCuentaScreenState extends State<EditarCuentaScreen> {
  TextEditingController nombre = TextEditingController();
  TextEditingController correo = TextEditingController();

  bool isEnabled = false;
  bool isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;

  void getUserCrendetials(String userId) {
    DatabaseReference db_ref = FirebaseDatabase.instance.ref().child('users');
    DataSnapshot dataSnapshot;

    db_ref.child(userId).once().then((value) {
      dataSnapshot = value.snapshot;

      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> userData =
            dataSnapshot.value as Map<dynamic, dynamic>;

        if (userData['name'] != null && userData['email'] != null) {
          setState(() {
            nombre.text = userData['name'];
            correo.text = userData['email'];
          });
        } else {
          setState(() {
            nombre.text = 'Sin usuario';
            correo.text = 'El usuario no tiene correo';
          });
        }
      }
    });
  }

  void updateCredentials(String usuario, String email) {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2));

    DatabaseReference userRef = FirebaseDatabase.instance.ref().child('users');

    if (user != null) {
     userRef.child(user!.uid).update({
        'email': correo.text,
        'name': nombre.text,
      }).whenComplete(() {
        setState(() {
          isLoading = !isLoading;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Actualizacion exitosa'),
              content: const Text(
                  'Las credenciales han sido actualizadas correctamente'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserCrendetials(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Título para editar la información de la cuenta
            SwitchListTile(
                title: const Text('Activar ediccion de cuenta'),
                subtitle:
                    const Text('Activar para editar credenciales de usuario'),
                value: isEnabled,
                onChanged: (value) {
                  setState(() {
                    isEnabled = !isEnabled;
                  });
                }),
            // Campos para editar la cuenta, como nombre, correo electrónico, contraseña, etc.
            // Por ejemplo:
            TextFormField(
              controller: nombre,
              decoration: isEnabled
                  ? InputDecoration(
                      hintText: nombre.text,
                      // labelText: 'Usuario',
                    )
                  : const InputDecoration(labelText: 'Usuario', enabled: false),
            ),
            TextFormField(
              controller: correo,
              decoration: isEnabled
                  ? InputDecoration(
                      hintText: correo.text,
                    )
                  : const InputDecoration(
                      labelText: 'Correo electronico', enabled: false),
            ),
            const SizedBox(height: 20),
            // Botón para guardar los cambios
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      
                      color: Colors.amber[900],
                    ),
                  )
                :  ElevatedButton(
                    
                    onPressed: isEnabled ? () {
                      // Puedes agregar la lógica para guardar la información de la cuenta
                      // y navegar de regreso a la pantalla de configuración
                      updateCredentials(nombre.text, correo.text);
                    }: null,
                    child: const Text('Guardar Cambios'),
                  ),
          ],
        ),
      ),
    );
  }
}
