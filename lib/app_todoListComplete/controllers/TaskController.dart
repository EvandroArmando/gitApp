import 'package:flutter/material.dart';
import 'package:git_app/app_todoListComplete/model/task.dart';

class Taskcontroller2 extends ChangeNotifier {
  List<TaskNewModel> task = [];

  set taskAdd(TaskNewModel task) {
    this.task.add(task);
    notifyListeners();
  }
}
