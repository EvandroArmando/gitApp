import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:git_app/tudo_list_app/interfaces/i_crud.dart';
import 'package:git_app/tudo_list_app/models/enum_states.dart';
import 'package:git_app/tudo_list_app/models/tasks.dart';

// Gerenciador de tarefas usando StateNotifier
class TaskRepository extends StateNotifier<List<TasksModel>> implements ICrud {
  TaskRepository()
    : super([
        TasksModel(
          id: 1,
          tittle: "Tarefa 1",
          description: "Descrição da tarefa 1",
          status: Status.initial,
        ),
        TasksModel(
          id: 2,
          tittle: "Tarefa 2",
          description: "Descrição da tarefa 2",
          status: Status.initial,
        ),
        TasksModel(
          id: 3,
          tittle: "Tarefa 3",
          description: "Descrição da tarefa 3",
          status: Status.loaded,
        ),
        TasksModel(
          id: 4,
          tittle: "Tarefa 4",
          description: "Descrição da tarefa 4",
          status: Status.loading,
        ),
        TasksModel(
          id: 5,
          tittle: "Tarefa 5",
          description: "Descrição da tarefa 5",
          status: Status.loaded,
        ),
      ]);

  @override
  void create(TasksModel task) {
    state = [...state, task];
  }

  @override
  void delete(int id) {
    state = state.where((task) => task.id != id).toList();
    debugPrint("Tarefa $id deletada com sucesso");
  }
  

  @override
  void update(int id) {
    state =
        state.map((task) {
          if (task.id == id) {
            return task.copyWith(status: Status.loaded);
          }
          return task;
        }).toList();
  }

  @override
  List<TasksModel> getAll() {
    return state;
  }
}

final taskProvider = StateNotifierProvider<TaskRepository, List<TasksModel>>((ref,) {
  return TaskRepository();
});
