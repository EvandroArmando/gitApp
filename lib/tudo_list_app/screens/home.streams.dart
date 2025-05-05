import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_app/tudo_list_app/models/enum_states.dart';
import 'package:git_app/tudo_list_app/models/tasks.dart';
import 'package:git_app/tudo_list_app/repository/task_repository.dart';

class HomeStrems extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(taskProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Tarefas")),
      body: StreamBuilder<List<TasksModel>>(
        stream: repo.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final tarefa = tasks[index];
              return ListTile(
                title: Text(
                  tarefa.tittle,
                  style: TextStyle(
                    decoration: tarefa.status == Status.initial
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: tarefa.status == Status.loaded,
                      onChanged: (_) => repo.update(tarefa.id),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => repo.delete(tarefa.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => repo.create(
          TasksModel(
            id: DateTime.now().millisecondsSinceEpoch,
            tittle: "Nova Tarefa",
            description: "Descrição da nova tarefa",
            status: Status.initial,
          ),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
