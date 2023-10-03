import 'package:flutter/material.dart';
import 'package:storemap/presentation/containers/my_appbar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContainerWidget(
                  url:
                      'https://images.pexels.com/photos/802024/pexels-photo-802024.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  fi: BoxFit.cover  
                      ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('Comida'),),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Accesorios')),
                  ElevatedButton(onPressed: () {}, child: const Text('Ropa')),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ContainerWidget(
                      url:
                          'https://images.pexels.com/photos/802024/pexels-photo-802024.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      fi: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ContainerWidget(
                      url:
                          'https://images.pexels.com/photos/802024/pexels-photo-802024.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      fi: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ContainerWidget(
                      url:
                          'https://images.pexels.com/photos/802024/pexels-photo-802024.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      fi: BoxFit.cover,
                    ),
                  ),
                
                ],
                scrollDirection: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String url;
  final BoxFit fi;
  const ContainerWidget({super.key, required this.url,required this.fi});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Image.network(
        url,
        fit: fi,
      ),
    );
  }
}
