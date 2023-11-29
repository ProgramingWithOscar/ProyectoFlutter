import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete SharedPreferences
import 'package:storemap/firebase_options.dart';

import 'package:storemap/presentation/screens/auth_screen.dart';
import 'package:storemap/presentation/screens/bienvenida.dart';
import 'package:storemap/presentation/screens/main_screen.dart';
import 'package:storemap/presentation/screens/register_screen.dart';
import 'package:storemap/theme/app_theme.dart';
import 'package:storemap/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    
  );

  GoogleSignIn googleSignIn = GoogleSignIn(clientId: 'TU_CLIENT_ID', scopes: ['email']); // Reemplaza 'TU_CLIENT_ID' con tu ID de cliente de Google

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _showSplash = ref.watch(showSplashProvider);
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Store Map',
      theme: appTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // Rutas de la aplicación
      routes: {
        '/': (context) {
          // Verifica si el usuario está autenticado en SharedPreferences.
          Future<bool> checkAuthentication() async {
            final prefs = await SharedPreferences.getInstance();
            final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
            return isLoggedIn;
          }

          bool _showSplash = true;

          // Mostrar la pantalla de bienvenida durante 2 segundos.
          Future.delayed(Duration(seconds: 2), () {
            ref.read(showSplashProvider.notifier).state = false;
          });

          final showSplash = ref.watch(showSplashProvider);

          if (showSplash) {
            return SplashScreen(); // Mostrar la pantalla de bienvenida
          } else {
            return FutureBuilder<bool>(
              future: checkAuthentication(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return snapshot.data == true ? MainScreen() : LoginPage();
              },
            );
          }
        },
        '/register': (context) => const SignUpPage(),
        // Otras rutas...5
      },
        // Otras rutas...
      
    );
  }
}
