import 'package:flutter/material.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Opciones de Configuración',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Editar Cuenta'),
              onTap: () {
                // Navegar a la pantalla de edición de cuenta
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditarCuentaScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.light_mode_outlined),
              title: const Text('Activar Dark mode'),
              trailing: Switch(
                value: false,
                onChanged: (value){

                },
              ),
              onTap: () {
                // Navegar a una pantalla relacionada con la activación del modo oscuro si es necesario.
              },
            ),
            // Agrega más opciones de configuración aquí
          ],
        ),
      ),
    );
  }
}

class EditarCuentaScreen extends StatelessWidget {
  const EditarCuentaScreen({Key? key});

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
            const Text(
              'Editar Información de Cuenta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Aquí puedes agregar campos para editar la cuenta, como nombre, correo electrónico, contraseña, etc.
            // Por ejemplo:
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Contraseña',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para guardar la información de la cuenta
                // y navegar de regreso a la pantalla de configuración
                Navigator.of(context).pop();
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
