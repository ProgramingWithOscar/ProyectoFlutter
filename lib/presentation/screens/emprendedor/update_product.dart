import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storemap/presentation/screens/emprendedor/Home_emprender.dart';

class UpdateRecord extends StatefulWidget {
  String Contact_Key;
  UpdateRecord({required this.Contact_Key});

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController contactName = new TextEditingController();
  TextEditingController contacPrice = new TextEditingController();
  TextEditingController contacCategory = new TextEditingController();
  TextEditingController contacLink = new TextEditingController();
  TextEditingController contactDescription = TextEditingController();
  var url;
  var url1;
  File? file;
  ImagePicker image = ImagePicker();
  DatabaseReference? db_Ref;

  @override
  void initState() {
    super.initState();
    db_Ref = FirebaseDatabase.instance.ref().child('contacts');
    Contactt_data();
  }

  void Contactt_data() async {
    DataSnapshot snapshot = await db_Ref!.child(widget.Contact_Key).get();

    Map Contact = snapshot.value as Map;

    setState(() {
      contactName.text = Contact['name'];
      contacPrice.text = Contact['price'];
      contacCategory.text = Contact['category'];
      contacLink.text = Contact['whatsapp'];
      url = Contact['url'];
      contactDescription.text = Contact['description'] ?? 'No hay descripcion';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Record'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: url == null
                    ? MaterialButton(
                        height: 100,
                        child: Image.file(
                          file!,
                          fit: BoxFit.fill,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      )
                    : MaterialButton(
                        height: 100,
                        child: CircleAvatar(
                          maxRadius: 100,
                          backgroundImage: NetworkImage(
                            url,
                          ),
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _FormField(
                label: 'Nombre del producto',
                name: contactName,
                filled: true,
                hinText: 'Nombre del producto'),
            const SizedBox(
              height: 5,
            ),
            _FormField(
                label: 'Precio',
                name: contacPrice,
                filled: true,
                hinText: 'Precio'),
            const SizedBox(
              height: 5,
            ),
            _FormField(
                label: 'Categoria',
                name: contacCategory,
                filled: true,
                hinText: 'Categoria'),
            const SizedBox(
              height: 5,
            ),
            _FormField(
                label: 'Link de WhatsApp',
                name: contacLink,
                filled: true,
                hinText: 'Link de WhatsApp'),
                  const SizedBox(
              height: 5,
            ),
             _FormField(
                label: 'Descripcion',
                name: contactDescription,
                filled: true,
                hinText: 'Descripcion del producto'),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                // getImage();

                if (file != null) {
                  uploadFile();
                } else {
                  directupdate();
                }
              },
              child: Text(
                "Update",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
              color: Colors.indigo[900],
            ),
          ],
        ),
      ),
    );
  }

  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      url = null;
      file = File(img!.path);
    });

    // print(file);
  }

  uploadFile() async {
    try {
      var imagefile = FirebaseStorage.instance
          .ref()
          .child("contact_photo")
          .child("/${contactName.text}.jpg");
      UploadTask task = imagefile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url1 = await snapshot.ref.getDownloadURL();
      setState(() {
        url1 = url1;
      });
      if (url1 != null) {
        Map<String, String> Contact = {
          'name': contactName.text,
          'number': contacPrice.text,
          'url': url1,
        };

        db_Ref!.child(widget.Contact_Key).update(Contact).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Home(),
            ),
          );
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  directupdate() {
    if (url != null) {
      Map<String, String> Contact = {
        'name': contactName.text,
        'price': contacPrice.text,
        'category': contacCategory.text,
        'link': contacLink.text,
        'url': url,
        'description' : contactDescription.text
      };

      db_Ref!.child(widget.Contact_Key).update(Contact).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Home(),
          ),
        );
      });
    }
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController name;
  bool filled;
  final String hinText;
  final String label;

  _FormField(
      {super.key,
      required this.name,
      required this.hinText,
      required this.filled,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: TextFormField(
        controller: name,
        decoration: InputDecoration(
          label: Text(label),
          filled: filled,
          fillColor: Colors.white,
          hintText: hinText,
        ),
      ),
    );
  }
}
