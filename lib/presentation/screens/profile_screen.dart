import 'package:flutter/material.dart'; // Importa la biblioteca Flutter para crear la interfaz de usuario.
import 'package:flutter/cupertino.dart'; // Importa la biblioteca Cupertino para widgets específicos de iOS.
import 'package:image_picker/image_picker.dart'; // Importa la biblioteca para seleccionar imágenes desde la galería.
import 'dart:io'; // Importa la biblioteca 'dart:io' para trabajar con archivos locales.

import 'package:storemap/widgets/favorite_widget.dart'; // Importa un widget personalizado llamado 'FavoriteWidget'.

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage; // Declara una variable para la imagen de perfil.

  Future<void> _selectNewProfilePicture() async {
    final picker = ImagePicker(); // Crea una instancia de 'ImagePicker' para seleccionar imágenes.
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Abre la galería y selecciona una imagen.

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Almacena la imagen seleccionada en '_profileImage'.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Hola Carlos', // Título de la aplicación.
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 100,
                      backgroundImage: _profileImage != null
                          ? Image.file(_profileImage!).image
                          : NetworkImage(
                              'https://images.freeimages.com/images/large-previews/d60/dollhouse-family-portraits-1419165.jpg',
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CupertinoButton(
                        onPressed: () {
                          _selectNewProfilePicture(); // Botón para seleccionar una nueva imagen de perfil.
                        },
                        child: Icon(CupertinoIcons.camera_fill,), // Icono de cámara.
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CupertinoFormSection(
              children: [
                CupertinoTextFormFieldRow(
                  placeholder: 'Nombre',
                  enabled: false, // Campo de texto para el nombre, deshabilitado.
                ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Aca va la info',
                  enabled: false, // Otro campo de texto, deshabilitado.
                ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Aca va la info',
                  keyboardType: TextInputType.emailAddress,
                  enabled: false, // Campo de texto para el correo electrónico, deshabilitado.
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Favorites', // Encabezado para la sección de favoritos.
              style: TextStyle(letterSpacing: 3, fontSize: 20),
            ),
            SizedBox(
              height: 200, // Ajusta la altura según tus necesidades.
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  FavoriteWidget(
                    url:
                        'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',
                  ),
                  // Aquí se muestran varios 'FavoriteWidget' con imágenes de ejemplo.
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
