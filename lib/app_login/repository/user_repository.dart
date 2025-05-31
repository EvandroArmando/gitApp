import 'package:flutter/material.dart';
import 'package:git_app/app_login/Interfaces/initial_state.dart';
import 'package:git_app/app_login/Interfaces/observer_login.dart';
import 'package:git_app/app_login/db/users.db.dart';
import 'package:git_app/app_login/repository/models/user_model.dart';

class UserRepository extends ObserverLogin<InitialState> {
  UserRepository() : super(InitialState()) {
    loadData();
  }
  UsersDb db = UsersDb();
  late UserModel users;
  loadData() {
    db.loadData;
    users = db.users!;
  }

  bool login({required String name, required String password}) {
    debugPrint('email:${users.email}, password:${users.password}');
    if (name == users.email && password == users.password) return true;
    
    return false;
  }
}
