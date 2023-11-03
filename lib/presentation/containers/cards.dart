import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storemap/presentation/screens/products_screen_details.dart';
import 'package:storemap/widgets/favorite_provider.dart';

class CardType1 extends ConsumerWidget {
  final String name;
  final String stars;
  final String url;
  final String price;
  final String description;
  final String whatsaap;
  const CardType1(
      {required this.name,
      required this.stars,
      required this.url,
      required this.price,
      required this.description,
      required this.whatsaap
      });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteP = ref.watch(isFavoriteProvider(url));
    final lista = ref.watch(productsFavorites);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductsDetailsScreen(
              imageUrl: url,
              name: name,
              price: price,
              description: description,
              stars: stars,
              whatsaap: whatsaap,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        print('Erro na imagem');
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (!isFavoriteP) {
                      // list.add(url);
                      // var lista = ref.read(productsFavorites);
                      // lista = [...lista, url];
                      ref
                          .read(productsFavorites.notifier)
                          .addProductToFavorites(url);
                      print('Producto agregado a favoritos');
                      print(lista);
                    } else {
                      ref
                          .read(productsFavorites.notifier)
                          .removeProductFromFavorites(url);
                      print('Producto agregado a favoritos');
                    }

                    ref
                        .read(isFavoriteProvider(url).notifier)
                        .update((state) => !state);
                    // if (isFavoriteP) {
                    //   ref.read(isFavoriteProvider.notifier).update((state) => true);
                    // } else {
                    //   ref.read(productFavorites).add(url);
                    // }
                  },
                  icon: Icon(
                    isFavoriteP ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$$price',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          Text(
                            stars,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
