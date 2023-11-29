import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storemap/presentation/screens/emprendedor/Home_emprender.dart';
import 'package:storemap/presentation/screens/settings_screen.dart';

class CreateProduct extends StatefulWidget {
  @override
  State<CreateProduct> createState() => CreateProductState();
}

class CreateProductState extends State<CreateProduct> {
  List<String> Categories = ['Comida', 'Ropa', 'Accesorios'];
  TextEditingController name = TextEditingController();
  TextEditingController precio = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isLoading = false;
  File? file;
  ImagePicker image = ImagePicker();

  var url;
  DatabaseReference? dbRef;
  final user = FirebaseAuth.instance.currentUser;
  String? selectedCategory;
  @override
  void initState() {
    super.initState();
    selectedCategory;
    dbRef = FirebaseDatabase.instance.ref().child('contacts');
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar producto',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: color.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: 200,
                  width: 200,
                  child: file == null
                      ? IconButton(
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 90,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          onPressed: () {
                            getImage();
                          },
                        )
                      : MaterialButton(
                          height: 100,
                          child: Image.file(
                            file!,
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {
                            getImage();
                          },
                        )),
            ),
            const Center(
              child: Text('Todos los campos son obligatorios'),
            ),
            const SizedBox(
              height: 10,
            ),
            _FormField(
                name: name, filled: true, hinText: 'Nombre del producto'),
            const SizedBox(
              height: 10,
            ),
            _FormField(name: precio, filled: true, hinText: 'Precio Unidad'),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(13),
              child: DropdownButtonFormField<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: Categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  hintText: 'Seleccione la Categoría',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _FormField(
                name: link,
                filled: true,
                hinText: 'Ingrese el numero de WhatsApp'),
            const SizedBox(
              height: 10,
            ),
            _FormField(
                name: description,
                filled: true,
                hinText: 'Ingrese la descripcion del producto'),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                // getImage();

                if (file != null) {
                  uploadFile();
                }
              },
              child: isLoading
                  ? CircularProgressIndicator(
                      color: color.primary,
                    )
                  : Text(
                      "Agregar articulo",
                      style: TextStyle(
                        color: color.primary,
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
          .child("/${name.text}.jpg");
      UploadTask task = imagefile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      setState(() {
        url = url;
      });
      if (url != null &&
          user != null &&
          name.text.isNotEmpty &&
          precio.text.isNotEmpty &&
          selectedCategory!.isNotEmpty &&
          link.text.isNotEmpty &&
          description.text.isNotEmpty) {
        Map<String, String> Contact = {
          'name': name.text,
          'price': precio.text,
          'category': selectedCategory!,
          'whatsapp': link.text,
          'url': url,
          'description': description.text,
          'user_id': user!.uid,
        };

        dbRef!.push().set(Contact).whenComplete(() {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Producto Agregado'),
                content: const Text('El producto se ha agregado con éxito.'),
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
      } else {
        setState(() {
          isLoading = !isLoading;
        });
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Campos Incompletos'),
              content: const Text(
                  'Por favor, complete todos los campos antes de agregar el producto.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cerrar el cuadro de diálogo
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController name;
  bool filled;
  final String hinText;

  _FormField(
      {super.key,
      required this.name,
      required this.hinText,
      required this.filled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: TextFormField(
        controller: name,
        decoration: InputDecoration(
          filled: filled,
          fillColor: Colors.white,
          hintText: hinText,
        ),
      ),
    );
  }
}
