import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Hola Carlos',
            ),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 5,
          ),
        ),
        body: ListView(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: CircleAvatar(
                  maxRadius: 100,
                  backgroundImage: NetworkImage(
                      'https://images.freeimages.com/images/large-previews/d60/dollhouse-family-portraits-1419165.jpg'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              children: [
                Text(
                  'Nombre',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FieldContainer(
                    labelText: 'Aca va la info',
                    helperText: 'Your Name',
                    icono: Icon(Icons.person),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FieldContainer(
                    labelText: 'Aca va la info',
                    helperText: 'Identification',
                    icono: Icon(Icons.document_scanner_rounded),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FieldContainer(
                    labelText: 'Aca va la info',
                    helperText: 'Email',
                    icono: Icon(Icons.email_rounded),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Favorites', style: TextStyle(letterSpacing: 3, fontSize: 20)),
              ],
            ),
            SizedBox(
              height: 200, // Ajusta la altura según tus necesidades
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const FavoriteWidget(url: 'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',),
                  const FavoriteWidget(url: 'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',),
                  const FavoriteWidget(url: 'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',),
                  const FavoriteWidget(url: 'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteWidget extends StatelessWidget {
  final String url;

  const FavoriteWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 0),
            )
          ]),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class FieldContainer extends StatelessWidget {
  final String labelText;
  final String helperText;
  final Icon icono;

  const FieldContainer({
    Key? key,
    required this.labelText,
    required this.helperText,
    required this.icono,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        icon: icono,
        labelText: labelText,
        helperText: helperText,
        filled: true,
      ),
    );
  }
}
