import 'package:flutter/widgets.dart';
import 'package:git_app/mvvm/utils/result/comand.dart';
import 'package:git_app/mvvm/utils/result/result.dart';
import 'package:git_app/mvvm/data/repositories/todos/todos_repository.dart';
import 'package:git_app/mvvm/domain/models/todo.dart';

class TodoViewModel extends ChangeNotifier {
  TodoViewModel({required TodosRepository todosRepository})
    : _todosRepository = todosRepository {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    removeTodo = Command1(_removeTodo);
  }
  final TodosRepository _todosRepository;
  late Command0 load;
  late Command1<Todo, String> addTodo;
  late Command1<void, Todo> removeTodo;

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<Result> _load() async {
    await Future.delayed(const Duration(seconds: 1));
    final result = await _todosRepository.get();
    switch (result) {
      case Ok<List<Todo>>():
        _todos = result.value;
        notifyListeners();

        break;
      case Error():
      //implementar o loging
    }

    return result;
  }

  Future<Result<Todo>> _addTodo(String name) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await _todosRepository.add(name);
    switch (result) {
      case Ok<Todo>():
        _todos.add(result.value);
        notifyListeners();
        break;
    }
    return result;
  }

  Future<Result<void>> _removeTodo(Todo todo) async {
    await Future.delayed(Duration(seconds: 1));
    final result = await _todosRepository.delete(todo);
    switch (result) {
      case Ok<void>():
        todos.remove(todo);
        notifyListeners();
        break;
    }
    return result;
  }
}
