import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/presentation/screens/auth_screen.dart';
import 'package:storemap/presentation/screens/fisrt_screen.dart';
import 'package:storemap/presentation/screens/main_screen.dart';

import 'package:storemap/presentation/screens/register_screen.dart';
import 'package:storemap/theme/app_theme.dart';
import 'package:storemap/theme/theme_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

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
        '/': (context) => MainScreen(),
        '/register': (context) => SignupPage(),
      },
    );
  }
}
