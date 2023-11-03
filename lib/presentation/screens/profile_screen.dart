import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart'; // Importa la biblioteca Flutter para crear la interfaz de usuario.
import 'package:flutter/cupertino.dart'; // Importa la biblioteca Cupertino para widgets específicos de iOS.
import 'package:image_picker/image_picker.dart';
import 'package:storemap/presentation/screens/favorite_screen.dart'; // Importa la biblioteca para seleccionar imágenes desde la galería.
// Importa un widget personalizado llamado 'FavoriteWidget'.

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage; // Declara una variable para la imagen de perfil.
  User? user = FirebaseAuth.instance.currentUser;
  String? name;
  String? correo;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      print(user!.uid);
      displayUserInfo(user!.uid);
    }
  }

  Future<void> _selectNewProfilePicture() async {
    final picker =
        ImagePicker(); // Crea una instancia de 'ImagePicker' para seleccionar imágenes.
    final pickedFile = await picker.pickImage(
        source:
            ImageSource.gallery); // Abre la galería y selecciona una imagen.

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile
            .path); // Almacena la imagen seleccionada en '_profileImage'.
      });
    }
  }

  Future<void> displayUserInfo(String userId) async {
    print(user!.uid);
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');
    DataSnapshot dataSnapshot;

    await usersRef.child(userId).once().then((event) {
      dataSnapshot = event.snapshot;

      if (dataSnapshot.value != null) {
        print(dataSnapshot.value);
        Map<dynamic, dynamic> userData =
            dataSnapshot.value as Map<dynamic, dynamic>;

        if (userData['name'] != null) {
          print('User Data' + userData['name']);
          setState(() {
            correo = userData['email'];
            name = userData['name'];
            print('Name state' + name!);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                        child: const Icon(
                          CupertinoIcons.camera_fill,
                        ), // Icono de cámara.
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CupertinoFormSection(
              children: [
                CupertinoTextFormFieldRow(
                  initialValue: name ?? '',
                  placeholder: '$name',
                  enabled:
                      false, // Campo de texto para el nombre, deshabilitado.
                ),
                CupertinoTextFormFieldRow(
                  placeholder: '$correo',
                  enabled: false, // Otro campo de texto, deshabilitado.
                ),
              ],
            ),
            const SizedBox(
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Favorites', // Encabezado para la sección de favoritos.
                style: TextStyle(letterSpacing: 3, fontSize: 20),
              ),
            ),
            SizedBox(
                height: 200, // Ajusta la altura según tus necesidades.
                child: FavoritesScreen()),
          ],
        ),
      ),
    );
  }
}
