import 'package:git_app/app/do_it_app/models/task_model_do_it.dart';
import 'package:hive_flutter/adapters.dart';

class TaskDatabase {
 final Box<TaskModelDoIt> taskBox = Hive.box<TaskModelDoIt>('tasks');

  void addTask(TaskModelDoIt task) {
    taskBox.add(task);
  }

  List<TaskModelDoIt> getAllTasks() {
    return taskBox.values.toList();
  }

  void updateTask(int index, TaskModelDoIt task) {
    taskBox.putAt(index, task);
  }

  void deleteTask(int index) {
    taskBox.deleteAt(index);
  }
}