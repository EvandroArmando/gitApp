import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/mvvm/data/repositories/todos/todos_repository.dart';
import 'package:git_app/mvvm/data/repositories/todos/todos_repository_dev.dart';
import 'package:git_app/mvvm/domain/models/todo.dart';
import 'package:git_app/mvvm/ui/todo/viewmodel/todo_viewmode.dart';

void main() {
  late TodoViewModel todoViewModel;
  late TodosRepository todosRepository;
  setUp(() {
    todosRepository = TodosRepositoryDev();
    todoViewModel = TodoViewModel(todosRepository: todosRepository);
  });
  group("group test", () {
    test('Verify initial State  todo', () async {
      expect(todoViewModel.todos, isEmpty);
    });
    test('created Todo', () async {
      Todo td = Todo(id: 1, name: "Evandro");
      expect(todoViewModel.todos, isEmpty);
      final ret = await todoViewModel.addTodo.execute(td.name);
      expect(todoViewModel.todos.first.name, contains(td.name));
      expect(todoViewModel.todos.first.id, isNotNull);
      print(todoViewModel.todos.first.id);
    });

    test('delete todo', () async {
      expect(todoViewModel.todos, isEmpty);
      await todoViewModel.addTodo.execute("novo tudo");
      expect(todoViewModel.todos.first.name, contains("novo tudo"));
      await todoViewModel.removeTodo.execute(todoViewModel.todos.first);
      expect(todoViewModel.todos, isEmpty);
    });
  });
}
