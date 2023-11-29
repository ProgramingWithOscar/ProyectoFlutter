import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storemap/presentation/screens/editar_cuenta.dart';
import 'package:storemap/presentation/screens/emprendedor/Home_emprender.dart';
import 'package:storemap/presentation/screens/emprendedor/insert.dart';
import 'package:storemap/theme/theme_provider.dart';

// Pantalla de configuración
class ConfiguracionScreen extends ConsumerWidget {
  const ConfiguracionScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> signOut() async {
      // Borra el indicador de autenticación en SharedPreferences.
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);

      // Cierra la sesión en Firebase u otro sistema de autenticación (por ejemplo, Google Sign-In).
      // Realiza aquí la lógica necesaria para cerrar la sesión.

      // Redirige al usuario a la pantalla de inicio de sesión.
      Navigator.pushReplacementNamed(context, '/');
    }

    // Obtenemos el estado del modo oscuro desde el proveedor
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: TextButton.icon(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.logout_outlined),
            label: const Text('Cerrar sesion'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
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
                title: Text(
                    isDarkMode ? 'Desactivar Dark Mode' : 'Activar Dark Mode'),
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
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                  child: const Text('Soy emprendedor'),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Home()));
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

