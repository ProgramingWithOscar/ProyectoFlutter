import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:storemap/widgets/favorite_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;

  Future<void> _selectNewProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
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
                          _selectNewProfilePicture();
                        },
                        child: Icon(CupertinoIcons.camera_fill,),
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
                  enabled: false,
                ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Aca va la info',
                  enabled: false,
                ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Aca va la info',
                  keyboardType: TextInputType.emailAddress,
                  enabled: false,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Favorites',
              style: TextStyle(letterSpacing: 3, fontSize: 20),
            ),
            SizedBox(
              height: 200, // Ajusta la altura según tus necesidades
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  FavoriteWidget(
                    url:
                        'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',
                  ),
                  FavoriteWidget(
                    url:
                        'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',
                  ),
                  FavoriteWidget(
                    url:
                        'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',
                  ),
                  FavoriteWidget(
                    url:
                        'https://cdn.pixabay.com/photo/2023/08/26/14/19/cupcake-8215179_1280.jpg',
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

