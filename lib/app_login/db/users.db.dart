import 'dart:convert';

import 'package:git_app/app_login/repository/models/user_model.dart';

class UsersDb {
  String jsonUsers =
      '{"name":"evandro armando","password":"Amadeu-2019","endereco":"kilamba","email":"otalarmando@gmail.com","isAdmin":"true"}';
  UserModel? users;
  get loadData {
    final conv = jsonDecode(jsonUsers);
    users = UserModel.fromMap(conv);
  }
}
