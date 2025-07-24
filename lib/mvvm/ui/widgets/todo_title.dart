import 'package:flutter/material.dart';
import 'package:git_app/mvvm/utils/result/typedefs/on_delete_todo.dart';
import 'package:git_app/mvvm/domain/models/todo.dart';
import 'package:git_app/mvvm/ui/todo/viewmodel/todo_viewmode.dart';

class TodoTitle extends StatelessWidget {
  final TodoViewModel todoviewlmodel;
  final OnDeletetudo onDeletetudo;
  final Todo todo;
  const TodoTitle({required this.todo, required this.todoviewlmodel, Key? key, required this.onDeletetudo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(todo.id.toString()),
      title: Text(todo.name),
      trailing: IconButton(
        onPressed: () {
          todoviewlmodel.removeTodo.execute(todo);
        },
        icon: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
