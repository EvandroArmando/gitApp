import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/mvvm/data/services/api_client.dart';
import 'package:git_app/mvvm/domain/models/todo.dart';
import 'package:git_app/mvvm/utils/result/result.dart';

void main() {
  late ApiCliente apiCliente;
  setUp(() {
    apiCliente = ApiCliente();
  });
  group('Testable crud Todo', () {
    test('get All', () async {
      final response = await apiCliente.getTodos();
      expect((response as Ok).value, isA<List<Todo>>());
    });

    test('created', () async {
      Todo todo = Todo(id: 4, name: "quarto Todo");
      final result = await apiCliente.created(todo);
      expect((result as Ok).value, isA<Todo>());
    });
    test('deletebyId', () async {
      final result = await apiCliente.deleteById(id: 1);
      expect(result, isA<Result<void>>());
      //delete
    });
    test('getById', () async {
      final result = await apiCliente.getById(id: 1);
      expect((result) as Ok, isA<Result<Todo>>());
    });
    test('editbyId', () async {
      final Todo todo = Todo(id: 1, name: "primeiro todo");
      final result = await apiCliente.editById(id: 1,todo: todo);
      expect((result) as Ok, isA<Result<Todo>>());
    });
  });
}
