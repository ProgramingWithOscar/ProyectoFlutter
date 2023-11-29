import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/theme/app_theme.dart';

// Define un proveedor de notificador de estado para el tema
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

// Clase ThemeNotifier que extiende StateNotifier<AppTheme>
class ThemeNotifier extends StateNotifier<AppTheme> {
  // Constructor de ThemeNotifier que inicializa el estado con un nuevo objeto AppTheme
  ThemeNotifier() : super(AppTheme());

  // Método para alternar entre los modos oscuro y claro
  void toggleDarkMode() {
    // Actualiza el estado, copiando el valor actual y cambiando la propiedad isDarkMode
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  // Método para cambiar el índice de color seleccionado
  void changeColorIndex(int colorIndex) {
    // Actualiza el estado, copiando el valor actual y cambiando la propiedad selectedColor
    state = state.copyWith(selectedColor: colorIndex);
  }
}

final showSplashProvider = StateProvider<bool>((ref) => true);
