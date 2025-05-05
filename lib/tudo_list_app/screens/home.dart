import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_app/tudo_list_app/models/enum_states.dart';
import 'package:git_app/tudo_list_app/models/tasks.dart';
import 'package:git_app/tudo_list_app/repository/task_repository.dart';
import 'package:git_app/tudo_list_app/screens/update_and_delete.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final taskRepository = ref.read(taskProvider.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_taskController.text.isNotEmpty) {
            final newTask = TasksModel(
              id: DateTime.now().millisecondsSinceEpoch,
              description: 'trabalho-1',
              status: Status.initial,
              tittle: _taskController.text,
            );
            taskRepository.create(newTask);
            _taskController.clear();
          }
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("Lista de Tarefas")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  final newTask = TasksModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    description: '',
                    status: Status.initial,
                    tittle: '',
                  );
                  taskRepository.create(newTask);
                  _taskController.clear();
                }
              },
              decoration: const InputDecoration(
                labelText: "Digite uma tarefa",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final tarefa = tasks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => UpdateAndDelete(
                              id: tarefa.id,

                              description: tarefa.description,
                              tittle: '',
                            ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      tarefa.tittle,
                      style: TextStyle(
                        decoration:
                            tarefa.status == Status.initial
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                    subtitle: Text(tarefa.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: tarefa.status == Status.loaded,
                          onChanged: (bool? value) {
                            final newStatus =
                                value == true ? Status.loaded : Status.initial;
                            taskRepository.update(tarefa.id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            taskRepository.delete(tarefa.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
