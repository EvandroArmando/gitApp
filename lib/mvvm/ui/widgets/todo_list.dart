import 'package:flutter/material.dart';
import 'package:git_app/mvvm/utils/result/typedefs/on_delete_todo.dart';
import 'package:git_app/mvvm/domain/models/todo.dart';
import 'package:git_app/mvvm/ui/todo/viewmodel/todo_viewmode.dart';
import 'package:git_app/mvvm/ui/widgets/todo_title.dart';

class TodoList extends StatelessWidget {
 final  OnDeletetudo onDeletetudo;
 
  final List<Todo> todo;
  final TodoViewModel todoviewlmodel;
  const TodoList({required this.todo, Key? key, required this.todoviewlmodel, required this.onDeletetudo})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (todo.isEmpty) {
      return Center(child: Text("Nenhuma tarefa por enquanto"));
    }
    return ListView.builder(
      itemCount: todo.length,
      itemBuilder: (context, index) {
        return TodoTitle(
          todoviewlmodel: todoviewlmodel,
          todo: todo[index],
          onDeletetudo: onDeletetudo,
        );
      },
    );
  }
}
