import 'package:flutter/material.dart';
import 'package:git_app/app/do_it_app/Interfaces/base_state.dart';
import 'package:git_app/app/do_it_app/Interfaces/base_state_do_it_Initial.dart';
import 'package:git_app/app/do_it_app/Interfaces/base_state_do_it_sucess.dart';
import 'package:git_app/app/do_it_app/Interfaces/base_state_do_loading.dart';
import 'package:git_app/app/do_it_app/Interfaces/do_it_observer_%20.dart';
import 'package:git_app/app/do_it_app/database/task_database.dart';
import 'package:git_app/app/do_it_app/home_do_it_app.dart';
import 'package:git_app/app/do_it_app/models/task_model_do_it.dart';
import 'package:git_app/tudo_list_app/screens/home.dart';

class TaskRepositoryDoIt extends DoItObserver<BaseStateDoIt> {
  TaskRepositoryDoIt() : super(BaseStateDoItInitial());
  // ignore: prefer_final_fields
  BaseStateDoIt state = BaseStateDoItInitial();
  TaskDatabase db = TaskDatabase();
  List<void Function()> listener = [];
  List<TaskModelDoIt> tasks = [];

  get allTasks {
    _tasks = db.getAllTasks();
    return _tasks;
  }

  // ignore: unused_field, prefer_final_fields
  List<TaskModelDoIt> _tasks = [];

  Future<void> showToastMessage(BuildContext context, String s) async {
    String statValue = '';
    if (state is BaseStateDoItInitial) statValue = 'inicial';

    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text("estado inicial é $statValue:"),
        leading: Icon(Icons.info, color: Colors.blue),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text("Fechar"),
          ),
        ],
      ),
    );
  }

  Future<void> exits(BuildContext context) async {
    String statValue = '';
    if (state is BaseStateDoItInitial) statValue = 'inicial';

    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text("Já existe uma tarefa similiar"),
        leading: Icon(Icons.info, color: Colors.blue),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text("Fechar"),
          ),
        ],
      ),
    );
  }

  void addTask(BuildContext, context, TaskModelDoIt task) {
    state = BaseStateDoLoading();
    notifyCallback();
    Future.delayed(Duration(seconds: 6), () {
      for (var element in tasks) {
        if (element.title != task.title) {
          continue;
        }
        exits(context);
        return;
      }
      tasks.add(task);
      db.addTask(task);
      state = BaseStateDoItSucess(data: tasks);
      notifyCallback();
    });
  }

  loadTasks() {
    state = BaseStateDoLoading();
    tasks = allTasks;
    state = BaseStateDoItSucess(data: tasks);
    notifyCallback();
  }

  void addListener(void Function() listeners) {
    if (listener.contains(listeners)) return;
    listener.add(listeners);
  }

  void removeListener(void Function() listeners) {
    if (listener.contains(listeners)) listener.remove(listeners);
  }

  void notifyCallback() {
    for (int i = 0; i < listener.length; i++) {
      listener[i]();
    }
  }

  void removeTask(int index, TaskModelDoIt task) {
    state = BaseStateDoLoading();
    notifyCallback();
    Future.delayed(const Duration(seconds: 3), () {
      db.deleteTask(index);
      tasks.remove(task);
      state = BaseStateDoItSucess(data: tasks);
      notifyCallback();
    });
  }

  void updateTask(int index, TaskModelDoIt updateTask) {
    state = BaseStateDoLoading();
    notifyCallback();
    Future.delayed(Duration(seconds: 5), () {
      final task = tasks.firstWhere(
        (element) => element.title == updateTask.title,
      );
      if (task.title.isNotEmpty) {
        tasks[index] = updateTask;
        db.updateTask(index, updateTask);
        state = BaseStateDoItSucess(data: tasks);
        notifyCallback();
      }
    });
  }
}
