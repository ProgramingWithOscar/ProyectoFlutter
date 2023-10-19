class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;

  UserModel(
      {this.id = -1,
      required this.name,
      required this.email,
      required this.password});

  UserModel copyWith({int? id, String? name, String? email, String? password}) {
    return UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        password: map['password']);
  }
  Map<String, dynamic> toMap() =>
      {'id': id, 'name': name, 'email': email, 'password': password};
}
