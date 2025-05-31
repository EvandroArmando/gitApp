import 'package:flutter/material.dart';
import 'package:git_app/app_todoListComplete/controllers/TaskController.dart';
import 'package:git_app/app_todoListComplete/model/task.dart';

class HomeTodoList extends StatefulWidget {
  const HomeTodoList({Key? key}) : super(key: key);

  @override
  _HomeTodoListState createState() => _HomeTodoListState();
}

Taskcontroller2 controller = Taskcontroller2();

class _HomeTodoListState extends State<HomeTodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(child: const Text('Tela inicial')),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 12, bottom: 12),
            child: ListView.builder(
              itemCount: controller.task.length,
              itemBuilder: (context, index) {
                final modelo = controller.task[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${modelo.title}"),
                        SizedBox(height: 12),
                        Text("${modelo.description}"),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.taskAdd = TaskNewModel(
            title: "Primeiro modelo",
            description: "primeira tarfefa",
          );
        },
      ),
    );
  }
}
