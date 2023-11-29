import 'package:flutter/material.dart';
import 'package:storemap/presentation/containers/bottom_navigator.dart';
import 'package:storemap/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String description;
  final String stars;
  final String whatsaap;
  const ProductsDetailsScreen(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.description,
      required this.stars,
      required this.whatsaap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
            label: const Text(
              'Comprar en WhatsApp',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _openWhatsApp(whatsaap);
            },
            icon: const Icon(
              Icons.call_made,
              color: Colors.white,
            ),
          ),
        ),
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            _CustomSliverAppbar(url: imageUrl,),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => _Product(
                        url: imageUrl,
                        name: name,
                        description: description,
                        price: price,
                        stars: stars,
                        whatsapp: whatsaap),
                    childCount: 1))
          ],
        ));
  }
}


void _openWhatsApp(String phoneNumber) async {
  final whatsappUrl = 'https://api.whatsapp.com/send?phone=$phoneNumber';
  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    // Manejo de errores si no se puede abrir el enlace de WhatsApp
    print('No se pudo abrir WhatsApp');
  }
}


class _Product extends StatelessWidget {
  final String url;
  final String name;
  final String description;
  final String price;
  final String stars;
  final String whatsapp;
  const _Product({
    super.key,
    required this.url,
    required this.name,
    required this.description,
    required this.price,
    required this.stars,
    required this.whatsapp,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      url,
                      width: size.width * 0.3,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              //descripcion

              SizedBox(
                width: (size.width - 40) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textStyle.titleLarge,
                    ),
                    Text(description)
                  ],
                ),
              )
            ],
          ),
        ),

      ],
    );
  }
}

class _CustomSliverAppbar extends StatelessWidget {
  final String url;
  const _CustomSliverAppbar({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          // para ponder el etxto encima de las imagenes
          children: [
            // para que tome todo el espacio disponible
            SizedBox.expand(
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topLeft, stops: [
                  0.0,
                  0.3
                ], colors: [
                  Colors.black87,
                  Colors.transparent,
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
