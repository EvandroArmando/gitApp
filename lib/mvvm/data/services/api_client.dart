import 'dart:convert';
import 'dart:io';
import 'package:git_app/mvvm/domain/models/todo.dart';
import 'package:git_app/mvvm/utils/result/result.dart';

class ApiCliente {
  ApiCliente({
    int? port,
    String? host,
    HttpClient Function()? clientHttpFactory,
  }) : _host = host ?? "localhost",
       _port = port ?? 3000,
       _clientHttpFactory = clientHttpFactory ?? HttpClient.new;

  final String _host;
  final int _port;
  final HttpClient Function() _clientHttpFactory;

  Future<Result<List<Todo>>> getTodos() async {
    final client = _clientHttpFactory();
    try {
      final request = await client.get(_host, _port, "/todos");
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        final List<Todo> todos = json.map((e) => Todo.fromjson(e)).toList();
        return Result.ok(todos);
      } else {
        return Result.error(const HttpException("invalide response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

  Future<Result<void>> deleteById({int? id}) async {
    final cliente = _clientHttpFactory();
    try {
      final request = await cliente.delete(_host, _port, "/todos/$id");
      final response = await request.close();
      if (response.statusCode == 200) {
        return Result.ok(null);
      }
      return Result.error(HttpException("Invalide Response"));
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      cliente.close();
    }
  }

  Future<Result<Todo>> getById({int? id}) async {
    final cliente = _clientHttpFactory();
    try {
      final request = await cliente.get(_host, _port, "/todos/$id");
      final response = await request.close();
      if (response.statusCode == 200) {
        final json = await response.transform(utf8.decoder).join();
        final json_decoder = await jsonDecode(json);
        final data = Todo.fromjson(json_decoder);
        return Result.ok(data);
      }
      return Result.error(HttpException("Invalide Response"));
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      cliente.close();
    }
  }

  Future<Result<Todo>> created(Todo todo) async {
    final cliente = _clientHttpFactory();
    try {
      final request = await cliente.post(_host, _port, "/todos"
      );
      request.write(jsonEncode({"id": todo.id.toString(), "name": todo.name}));
      final response = await request.close();
      if (response.statusCode == 201) {
        final jsonData = await response.transform(utf8.decoder).join();
        final data = jsonDecode(jsonData);
        final Todo todo = Todo.fromjson(data);
        return Result.ok(todo);
      } else {
        return Result.error(HttpException("invalide requested"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<Todo>> editById({Todo? todo, int? id}) async {
    final cliente = _clientHttpFactory();
    try {
      final request = await cliente.put(_host, _port, "/todos/$id");
      request.write(jsonEncode({"name": todo!.name}));
      final response = await request.close();
      if (response.statusCode == 200) {
        final json = await response.transform(utf8.decoder).join();
        final json_decoder = await jsonDecode(json);
        final data = Todo.fromjson(json_decoder);
        return Result.ok(data);
      } else {
        if (response.statusCode == 404) {
          return Result.error(HttpException("Not Founded"));
        }
        return Result.error(HttpException("Invalide Response"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      cliente.close();
    }
  }
}
