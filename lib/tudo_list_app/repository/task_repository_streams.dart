import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_app/tudo_list_app/interfaces/i_crud.dart';
import 'package:git_app/tudo_list_app/models/enum_states.dart';
import 'package:git_app/tudo_list_app/models/tasks.dart';
import 'package:git_app/tudo_list_app/repository/task_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRepositoryStreams extends StateNotifier<List<TasksModel>>
    implements ICrud {
  final _controller = StreamController<List<TasksModel>>.broadcast();
  TaskRepositoryStreams() : super([]) {
    _carregarLocalmente();
  }

  Stream<List<TasksModel>> get stream => _controller.stream;

  @override
  void create(TasksModel task) {
    state = [...state, task];
    _controller.add(state);
    _salvarLocalmente();
  }

  @override
  void delete(int id) {
    state = state.where((element) => element.id != id).toList();
    _controller.add(state);
    _salvarLocalmente();
  }

  @override
  void getAll() {
    // TODO: implement getAll
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
    _controller.add(state);
    _salvarLocalmente();
  }

  Future<void> _carregarLocalmente() async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = prefs.getString("tasks");

    if (listaJson != null) {
      final List<dynamic> listaDecodificada = jsonDecode(listaJson);
      state =
          listaDecodificada.map((item) => TasksModel.fromJson(item)).toList();
      _controller.add(state);
    }
  }

  Future<void> _salvarLocalmente() async {
    final prefs = await SharedPreferences.getInstance();
    final listaJson = jsonEncode(state.map((t) => t.toJson()).toList());
    await prefs.setString("tasks", listaJson);
  }

  final taskProviderStream =
      StateNotifierProvider<TaskRepositoryStreams, List<TasksModel>>((ref) {
        return TaskRepositoryStreams();
      });
}
