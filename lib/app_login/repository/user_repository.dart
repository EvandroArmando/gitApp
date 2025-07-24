import 'package:flutter/material.dart';
import 'package:git_app/app_login/Interfaces/base_state.dart';
import 'package:git_app/app_login/Interfaces/initial_state.dart';
import 'package:git_app/app_login/Interfaces/loading_state.dart';
import 'package:git_app/app_login/Interfaces/observer_login.dart';
import 'package:git_app/app_login/db/users.db.dart';
import 'package:git_app/app_login/repository/models/user_model.dart';

class UserRepository extends ObserverLogin<BaseState> {
  UserRepository() : super(InitialState()) {
    loadData();
  }

  List<void Function()> listF = [];

  UsersDb db = UsersDb();
  ValueNotifier<String> imagem = ValueNotifier('');
  late UserModel users;
  loadData() {
    db.loadData;
    users = db.users!;
  }

  set imagemm(String imagem) {
    imagem = imagem;
  }

  Future<bool> login({required String name, required String password}) async {
    state = LoadingState();
    notifyCallback();
    debugPrint('email: ${users.email}, password: ${users.password}');
    return await Future.delayed(Duration(seconds: 9), () {
      if (name == users.email && password == users.password) {
        state = InitialState();
        notifyCallback();
        return true;
      } else {
        state = InitialState();
        notifyCallback();
        debugPrint('Senha incorreta!');
        return false;
      }
    });
  }

  addListners(void Function() fu) {
    listF.add(fu);
  }

  removeListners(void Function() fu) {
    for (var i = 0; i < listF.length; i++) {
      listF.remove([i]);
    }
  }

  notifyCallback() {
    for (var i = 0; i < listF.length; i++) {
      listF[i].call();
    }
  }
}
