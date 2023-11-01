import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/widgets/favorite_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesList = ref.watch(productsFavorites);
    
    return ListView.builder(
      scrollDirection: Axis
          .horizontal, // Establece la dirección de desplazamiento horizontal.
      itemCount: favoritesList.length,
      itemBuilder: (context, index) {
        final url = favoritesList[index];
        return FavoriteWidget(
            url: url,
            onTap: (url) {
              ref.read(isFavoriteProvider(url).notifier).update((state) => !state);
              ref
                  .read(productsFavorites.notifier)
                  .removeProductFromFavorites(url);
            });
      },
    );
  }
}

class FavoriteWidget extends StatelessWidget {
  final String url;
  final Function onTap;
  const FavoriteWidget({
    Key? key,
    required this.url,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(children: [
          Container(
            width: 140,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber[900], // Color de fondo gris claro
                ),
                child: IconButton(
                  onPressed: () {
                    onTap(url);
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
