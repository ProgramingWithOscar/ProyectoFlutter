import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:storemap/presentation/screens/emprendedor/insert.dart';
import 'package:storemap/presentation/screens/emprendedor/update_product.dart';
import 'package:storemap/presentation/screens/settings_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  Query db_refe = FirebaseDatabase.instance.ref().child('contacts');
  DatabaseReference db_Ref = FirebaseDatabase.instance.ref().child('contacts');
  
  @override
  void initState() {
    super.initState();
    if (user != null) {
      // Crear una referencia a la base de datos de Firebase para los productos del usuario actual.

      // Realizar una consulta para obtener solo los productos del usuario actual.
      db_refe = db_Ref.orderByChild('user_id').equalTo(user!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateProduct(),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Productos',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: color.primary,
      ),
      body: FirebaseAnimatedList(
        query: db_refe, // Usar db_refe en lugar de db_Ref
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          Map Contact = snapshot.value as Map;
          Contact['key'] = snapshot.key;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdateRecord(
                    Contact_Key: Contact['key'],
                  ),
                ),
              );
              // print(Contact['key']);
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[900],
                    ),
                    onPressed: () {
                      db_Ref.child(Contact['key']).remove();
                    },
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      Contact['url'],
                    ),
                  ),
                  title: Text(
                    Contact['name'],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    Contact['category'],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
             
            
          
          );
       
        },
        
      ),
    );
  }
}
