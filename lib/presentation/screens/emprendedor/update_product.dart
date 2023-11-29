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
  List<String> Categories = ['Comida', 'Ropa', 'Accesorios'];

  String? selectedCategory;
  var url;
  var url1;
  File? file;
  ImagePicker image = ImagePicker();
  DatabaseReference? db_Ref;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    selectedCategory;
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
        title: const Text('Actualizar Producto'),
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
            const SizedBox(
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
            Padding(
              padding: const EdgeInsets.all(13),
              child: DropdownButtonFormField<String>(
                  value: contacCategory.text,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: Categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: contacCategory.text,
                  ),
                ),
            ),
            const SizedBox(
              height: 5,
            ),
            _FormField(
                label: 'Numero de WhatsApp',
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // getImage();

                if (file != null) {
                  uploadFile();
                } else {
                  directupdate();
                }
              },
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      "Actualizar",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
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
    setState(() {
      isLoading = !isLoading;
    });
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
          'price': contacPrice.text,
          'url': url1,
          'link': contacLink.text,
          'category': selectedCategory == null ? contacCategory.text : selectedCategory!,
          'description': contactDescription.text
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
    setState(() {
      isLoading = !isLoading;
    });
    if (url != null) {
      Map<String, String> Contact = {
        'name': contactName.text,
        'price': contacPrice.text,
        'category': selectedCategory == null ? contacCategory.text : selectedCategory!,
        'link': contacLink.text,
        'url': url,
        'description': contactDescription.text
      };

      db_Ref!.child(widget.Contact_Key).update(Contact).whenComplete(() {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Producto Actualizado'),
              content: const Text('El producto se ha actualizado con éxito.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Home(),
                      ),
                    ); // Cerrar el cuadro de diálogo
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
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
