import 'package:flutter/material.dart';
import 'package:git_app/mvvm/data/repositories/todos/todos_repository_dev.dart';
import 'package:git_app/mvvm/ui/todo/viewmodel/todo_viewmode.dart';
import 'package:git_app/mvvm/ui/widgets/todo_scren.dart';
import 'package:git_app/ui_mastery/ui/export_ui.dart';

Map<String, Widget Function(BuildContext context)> rotas = {
  "/login_ui_mastery": (context) => MasteryLoginDart(),
  "/home": (context) => HomeMasteryDart(),
  "/todo_scren_home":
      (context) => TodoScren(
        todoviewlmodel: TodoViewModel(todosRepository: TodosRepositoryDev()),
      ),
};
