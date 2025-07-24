import 'package:flutter/material.dart';
import 'package:git_app/mvvm/ui/todo/viewmodel/todo_viewmode.dart';
import 'package:git_app/mvvm/ui/widgets/addTodoWidget.dart';
import 'package:git_app/mvvm/ui/widgets/todo_list.dart';

class TodoScren extends StatefulWidget {
  final TodoViewModel todoviewlmodel;
  const TodoScren({required this.todoviewlmodel, super.key});

  @override
  State<TodoScren> createState() => _TodoScrenState();
}

class _TodoScrenState extends State<TodoScren> {
  @override
  void initState() {
    widget.todoviewlmodel.removeTodo.addListener(_onResult);
    super.initState();
  }

  void _onResult() {
    if (widget.todoviewlmodel.removeTodo.running) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => AlertDialog(
              content: IntrinsicHeight(
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      if (widget.todoviewlmodel.removeTodo.completed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("sucesso ao remover a tarefa.."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("erro ao remover a tarefa.."),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    widget.todoviewlmodel.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos Screen'),
        backgroundColor: Colors.blue,
      ),
      body: ListenableBuilder(
        listenable: widget.todoviewlmodel.load,
        builder: (context, value) {
          print(value);
          if (widget.todoviewlmodel.load.running) {
            return Center(child: CircularProgressIndicator());
          }
          if (widget.todoviewlmodel.load.failed) {
            return Center(child: const Text("Erro ao processar a lista"));
          }
          return value!;
        },
        child: ListenableBuilder(
          listenable: widget.todoviewlmodel,
          builder: (context, child) {
            return TodoList(
              onDeletetudo: (todo) {},
              todo: widget.todoviewlmodel.todos,
              todoviewlmodel: widget.todoviewlmodel,
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTodoWidget(todoViewModel: widget.todoviewlmodel);
            },
          );
        },
      ),
    );
  }
}
