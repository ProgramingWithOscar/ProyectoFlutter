import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/theme/app_theme.dart';


final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());



class ThemeNotifier extends StateNotifier<AppTheme> {
  //STATE = ESTADO = new AppTheme();
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }
}
