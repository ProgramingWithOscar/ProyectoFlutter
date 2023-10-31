import 'package:flutter_riverpod/flutter_riverpod.dart';

final listOfFavorites = StateProvider<List>((ref) => []);
final isFavorite = StateProvider<bool>((ref) => false);

