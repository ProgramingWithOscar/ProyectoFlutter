

import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteProvider = StateProvider.family((ref, url) => false);

final productsFavorites =
    StateNotifierProvider<ProductsFavoritesNotifier, List<String>>(
  (ref) => ProductsFavoritesNotifier([]),
);

class ProductsFavoritesNotifier extends StateNotifier<List<String>> {
  ProductsFavoritesNotifier(List<String> state) : super(state);

  void addProductToFavorites(String url) {
    state = [...state, url];
  }

  void removeProductFromFavorites(String url) {
    state = state.where((item) => item != url).toList();
  }
}
