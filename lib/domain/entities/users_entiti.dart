
enum Rol { customer, seller }

class User {
  final String name;
  final String email;
  final String telephone;
  final Rol rol;
  final String password;

  User(
      {
      required this.telephone,
      required this.rol,
      required this.password,
      required this.name,
      required this.email
      });
    

}
