import 'package:flutter/material.dart';
import 'package:storemap/presentation/containers/cards.dart';
import 'package:storemap/presentation/containers/container_widget.dart';
import 'package:storemap/presentation/screens/skelots/container_widget_skeleton.dart';
import 'package:storemap/presentation/slider/food_slider.dart';

class PagePrincipal extends StatelessWidget {
  const PagePrincipal({
    Key? key,
    required this.isLoading,
    required this.products,
  }) : super(key: key);

  final bool isLoading;
  final List<CardType1> products;

  @override
  Widget build(BuildContext context) {
    int maxDisplayedProducts = products.length; // Máximo de productos a mostrar

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/279.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        isLoading
            ? Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ContainerWidgetSkeleton();
                  },
                ),
              )
            : Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: products
                      .map((product) => ContainerWidget(
                            url: product.url,
                            name: product.name!,
                            onTap: () {
                              // _launchURL(product.url);
                            },
                          ))
                      .toList(),
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '¡Promos especiales!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        FoodSlider(),
        const SizedBox(
          height: 20,
        ),
        !isLoading
            ? Column(
                children: products.map((product) {
                  return CardType1(
                    name: product.name,
                    stars: product.stars,
                    url: product.url,
                    price: product.price,
                    description: product.description,
                    whatsaap: product.whatsaap,
                  );
                }).toList(),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.amber[900],
                ),
              ),
      ],
    );
  }
}
