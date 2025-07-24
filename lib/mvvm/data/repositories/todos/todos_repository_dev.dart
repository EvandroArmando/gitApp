import 'package:git_app/mvvm/utils/result/result.dart';
import 'package:git_app/mvvm/data/repositories/todos/todos_repository.dart';
import 'package:git_app/mvvm/domain/models/todo.dart';

class TodosRepositoryDev implements TodosRepository {
  List<Todo> _todos = [];

  @override
  Future<Result<Todo>> add(String name) async {
    final lastIndex = _todos.length;
    final todo = Todo(id: lastIndex + 1, name: name);
    return Result.ok(todo);
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    if (_todos.contains(todo)) {
      return Result.ok(null);
    }
    return Result.ok(null);
  }

  @override
  Future<Result<List<Todo>>> get() async {
    return Result.ok(_todos);
  }
}
