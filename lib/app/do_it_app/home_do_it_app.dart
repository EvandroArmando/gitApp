import 'package:flutter/material.dart';
import 'package:git_app/app/do_it_app/Interfaces/base_state_do_it_Initial.dart';
import 'package:git_app/app/do_it_app/Interfaces/base_state_do_loading.dart';
import 'package:git_app/app/do_it_app/models/task_model_do_it.dart';
import 'package:git_app/app/do_it_app/repository/task_repository.dart';
import 'package:git_app/app/do_it_app/views/edit_page.dart';
import 'package:git_app/app/do_it_app/views/home_do_it_app_add_tasks.dart';
import 'package:provider/provider.dart';

class HomeDoItApp extends StatefulWidget {
  const HomeDoItApp({Key? key}) : super(key: key);

  @override
  _HomeDoItAppState createState() => _HomeDoItAppState();
}

class _HomeDoItAppState extends State<HomeDoItApp> {
  TaskRepositoryDoIt taskRepositoryDoIt = TaskRepositoryDoIt();
  @override
  void initState() {
    super.initState();
    taskRepositoryDoIt.addListener(callback);
    print('---------' * 10);
    if (taskRepositoryDoIt.state is BaseStateDoItInitial) {
      print('taskRepositoryDoIt: ${taskRepositoryDoIt.state.toString()}');
    }
    Future.delayed(Duration(seconds: 10), () {
      taskRepositoryDoIt.loadTasks();
    });
  }
  @override
  void dispose() {
    taskRepositoryDoIt.removeListener(callback);
    super.dispose();
    super.dispose();
  }
  callback() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 72,
        title: const Text('Lista de tarefas'),
        centerTitle: true,
      ),
      body:
          taskRepositoryDoIt.state is BaseStateDoItInitial ||
                  taskRepositoryDoIt.state is BaseStateDoLoading
              ? Center(
                child: RepaintBoundary(child: CircularProgressIndicator()),
              )
              : taskRepositoryDoIt.tasks.length < 1 ||
                  taskRepositoryDoIt.tasks.isEmpty
              ? Center(child: Text('sem tarefas guardadas'))
              : Container(
                padding: EdgeInsets.only(top: 12, bottom: 12),
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  itemCount: taskRepositoryDoIt.tasks.length,
                  itemBuilder: (context, index) {
                    final modelo =
                        taskRepositoryDoIt.allTasks[index] as TaskModelDoIt;
                    return ListTile(
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${modelo.title}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '${modelo.description}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '${modelo.status}:',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              editTask(index, modelo);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              taskRepositoryDoIt.removeTask(index, modelo);
                            },
                          ),
                          Switch(
                            value:
                                modelo.status != TaskStatus.pending
                                    ? true
                                    : false,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      onTap: () {},
                    );
                  },
                ),
              ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        onPressed: navigate,
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigate() async {
    final TaskModelDoIt resposta = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HomeDoItAppAddTasks();
        },
      ),
    );
    taskRepositoryDoIt.addTask(BuildContext, context, resposta);
  }

  void editTask(int index, Object modelo) async {
    final TaskModelDoIt? value = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(
          name: 'EditPage',
          arguments: [modelo, 'valor passado'],
        ),
        builder: (context) {
          return EditPage();
        },
      ),
    );
    if (value != null) {
      taskRepositoryDoIt.updateTask(index, value);
    }
  }
}
