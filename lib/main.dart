import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storemap/firebase_options.dart';
import 'package:storemap/presentation/screens/emprendedor/Home_emprender.dart';
import 'package:storemap/presentation/screens/auth_screen.dart';
import 'package:storemap/presentation/screens/emprendedor/insert.dart';
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

// El resto de tu código permanece igual.


class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Store Map',
      /**
       * theme recibe una clase personalizada llamada appTheme que retorna un ThemeData, lo cual 
       * nos proporciona los temas de la aplicacion mediante un metodo .getTheme()
       */
      theme: appTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // Rutas de la aplicacion
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => const SignUpPage(),
      },
    );
  }
}
