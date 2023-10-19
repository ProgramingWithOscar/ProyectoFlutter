import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:storemap/entities/users.dart';

class DB {
  static Future<Database> _openDB() async{
    return openDatabase(join(await getDatabasesPath(),'Usuario.db'),
    onCreate: (db, version){
      return db.execute("CREATE TABLE usuarios (id INTEGER PRIMARY KEY, nombre TEXT, email TEXT, password TEXT)",);
    }, version: 1
    );
  }

  static Future<int> insert(UserModel usuario) async {
    Database database = await _openDB();

    return database.insert("usuarios", usuario.toMap());
  }

  static Future<int> delete(UserModel usuario) async{
    Database database = await _openDB();

    return database.delete("usuarios",where: "id = ?", whereArgs: [usuario.id]);
  }

  static Future<int> update(UserModel usuario) async{
    Database database = await _openDB();

    return database.update("usuarios", usuario.toMap(), where: "id = ?", whereArgs: [usuario.id]);
  }

  static Future<List<UserModel>> getUsers() async {
  final Database database = await _openDB();

  // Realiza una consulta para recuperar todos los usuarios
  final List<Map<String, dynamic>> usersData = await database.query("usuarios");

  return List.generate(usersData.length, (i) => UserModel(id:usersData[i]["id"],
  name: usersData[i]["nombre"],email: usersData[i]["email"],password: usersData[i]["password"]));
}

static Future<void> vaciarTablaUsuarios() async {
  final Database database = await _openDB();

  // Elimina todos los registros de la tabla "usuarios"
  await database.delete("usuarios");

  print("Tabla 'usuarios' vaciada.");
}

static Future<bool> validarCredenciales(String email, String password) async {
  final List<UserModel> usuarios = await DB.getUsers(); // Obtén la lista de usuarios de la base de datos.

  for (final usuario in usuarios) {
    if (usuario.email == email && usuario.password == password) {
      return true; // Credenciales válidas
    }
  }

  return false; // Credenciales no válidas
}

}
