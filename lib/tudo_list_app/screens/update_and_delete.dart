import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:git_app/tudo_list_app/repository/task_repository.dart';
import 'package:provider/provider.dart';

class UpdateAndDelete extends ConsumerStatefulWidget {
  final int id;
  final String tittle;
  final String description;
  const UpdateAndDelete({
    required this.id,
    required this.tittle,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  _UpdateAndDeleteState createState() => _UpdateAndDeleteState();
}

class _UpdateAndDeleteState extends ConsumerState<UpdateAndDelete> {
  @override
  Widget build(BuildContext context) {
    final taskRepository = ref.read(taskProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('detalhes da tarefa')),
      body: Column(
        children: [
          Text(widget.id.toString()),
          Text(widget.tittle),
          SizedBox(height: 10),
          Text(widget.description),
          Expanded(child: Column()),
          TextButton(
            onPressed: () {
              taskRepository.update(widget.id);
              Navigator.pop(context);
            },
            child: Text("Editar"),
          ),
        ],
      ),
    );
  }
}
