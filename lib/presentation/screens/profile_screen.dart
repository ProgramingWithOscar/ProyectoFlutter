import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storemap/presentation/screens/favorite_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  User? user = FirebaseAuth.instance.currentUser;
  String? name;
  String? correo;
  String? url; // La URL de la imagen de perfil.

  File? file;
  bool isLoading = false;
  ImagePicker image = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (user != null) {
      print(user!.uid);
      displayUserInfo(user!.uid);
      isLoading;
    }
  }

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      // Mostrar la imagen seleccionada en la cámara
      _profileImage = file;
    });
  }

  uploadFile() async {
    if (file == null) {
      // Asegúrate de que se haya seleccionado una imagen antes de intentar subirla.
      return;
    }

    try {
      var imagefile = FirebaseStorage.instance.ref().child("profile_photos").child(
          "${user!.uid}.jpg"); // Usar el UID del usuario como nombre del archivo.
      UploadTask task = imagefile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL().whenComplete(() {
        setState(() {
          isLoading = !isLoading;
        });
      });
      setState(() {
        url = url;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Foto Subida'),
            content: const Text('La foto de perfil se ha subido correctamente.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // Almacena la URL en Firebase Database
      saveImageUrl(url!);
    } catch (e) {
      print(e);
    }
  }

  void saveImageUrl(String imageUrl) {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');
    if (user != null) {
      usersRef.child(user!.uid).update({
        'profileImageUrl': imageUrl,
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

        if (userData['profileImageUrl'] != null) {
          setState(() {
            url = userData[
                'profileImageUrl']; // Asigna la URL almacenada en Firebase Database.
          });
        }
        if (userData['name'] != null) {
          setState(() {
            correo = userData['email'] ?? '';
            name = userData['name'] ?? '';
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => displayUserInfo(user!.uid),
      child: SafeArea(
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
                            : url != null
                                ? NetworkImage(url!)
                                : const NetworkImage(
                                    'https://images.freeimages.com/images/large-previews/d60/dollhouse-family-portraits-1419165.jpg',
                                  ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CupertinoButton(
                          onPressed: () {
                            getImage(); // Botón para seleccionar una nueva imagen de perfil.
                          },
                          child: const Icon(
                            CupertinoIcons.camera_fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: !isLoading
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          uploadFile(); // Botón para subir la foto de perfil.
                        },
                        child: const Text('Subir Foto de perfil'),
                      )
                    : Center(
                      child: CircularProgressIndicator(
                          color: Colors.amber[900],
                        ),
                    ),
              ),
              CupertinoFormSection(
                children: [
                  CupertinoTextFormFieldRow(
                    initialValue: name ?? '',
                    placeholder: name !=  null ? '$name' : 'Usuario logueado con google, edite su cuenta',
                    enabled: false,
                  ),
                  CupertinoTextFormFieldRow(
                    placeholder: correo != null ? '$correo' : 'Usuario logueado con google, edite su correo',
                    enabled: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 130,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Favorites',
                  style: TextStyle(letterSpacing: 3, fontSize: 20),
                ),
              ),
              SizedBox(
                  height: 200, // Ajusta la altura según tus necesidades.
                  child: FavoritesScreen()),
            ],
          ),
          // Añade el contenido de la sección de favoritos (FavoritesScreen).
        ),
      ),
    );
  }
}
