import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/presentation/screens/emprendedor/Home_emprender.dart';
import 'package:storemap/presentation/screens/emprendedor/insert.dart';
import 'package:storemap/theme/theme_provider.dart';

// Pantalla de configuración
class ConfiguracionScreen extends ConsumerWidget {
  const ConfiguracionScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos el estado del modo oscuro desde el proveedor
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return SafeArea(
      child: Scaffold(
      
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: TextButton.icon(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.logout_outlined), label: const Text('Cerrar sesion'),),
        ),
       
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              // Título de las opciones de configuración
              const Text(
                'Opciones de Configuración',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Elemento de lista para editar la cuenta
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
              // Elemento de lista para activar/desactivar el modo oscuro
              ListTile(
                leading: isDarkMode
                    ? const Icon(Icons.light_mode_outlined)
                    : const Icon(Icons.dark_mode_outlined),
                title: Text(isDarkMode ? 'Desactivar Dark Mode' : 'Activar Dark Mode'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    ref.read(themeNotifierProvider.notifier).toggleDarkMode();
                  },
                ),
                onTap: () {
                  // Puedes navegar a una pantalla relacionada con el modo oscuro si es necesario.
                },
              ),
                const SizedBox(height: 50,),
                 Center(
                  child: ElevatedButton(
                    child: const Text('Soy emprendedor'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                builder: (_) => Home()));
                  },
                  ),
                 )
              
              // Puedes agregar más opciones de configuración aquí
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla de edición de cuenta
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
            // Título para editar la información de la cuenta
            const Text(
              'Editar Información de Cuenta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Campos para editar la cuenta, como nombre, correo electrónico, contraseña, etc.
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
            // Botón para guardar los cambios
            ElevatedButton(
              onPressed: () {
                // Puedes agregar la lógica para guardar la información de la cuenta
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

