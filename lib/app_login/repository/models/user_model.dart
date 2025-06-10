class UserModel {
  String? name;
  String? password;
  String? endereco;
  String? email;
  bool? isAdmin;
  String? image;

  UserModel({
    this.image = '',
    this.name,
    this.password,
    this.endereco,
    this.email,
    this.isAdmin = false,
  });

  UserModel CopyWhit({
    String? name,
    String? password,
    String? endereco,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      password: password ?? this.password,
      endereco: endereco ?? this.endereco,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMapI() {
    Map<String, dynamic> map = {
      'name': this.name,
      'password': this.password,
      'endereco': endereco,
      'email': email,
    };
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> mapa) {
    return UserModel(
      email: mapa['email'],
      endereco: mapa['endereco'],
      password: mapa['password'],
      name: mapa['name'],
    );
  }

  UserModel.isAdmin()
    : isAdmin = true,
      email = 'otalarmando@gmail.com',
      password = 'Amadeu-2019';
}
