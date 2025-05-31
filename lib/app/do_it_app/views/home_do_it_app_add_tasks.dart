import 'package:flutter/material.dart';
import 'package:git_app/app/do_it_app/models/task_model_do_it.dart';

class HomeDoItAppAddTasks extends StatefulWidget {
  const HomeDoItAppAddTasks({Key? key}) : super(key: key);

  @override
  _HomeDoItAppAddTasksState createState() => _HomeDoItAppAddTasksState();
}
class _HomeDoItAppAddTasksState extends State<HomeDoItAppAddTasks> {
  final _keyform = GlobalKey<FormState>();
  final TextEditingController tittleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isSet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        toolbarHeight: 70,
        title: const Text('Adicionando tarefas'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _keyform,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: TextStyle(height: 2),
                'Titulo',
                textScaler: TextScaler.linear(2),
              ),
              TextFormField(
                controller: tittleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'nao pode ser vazio';
                  }

                  if (value.length <= 2) {
                    return 'titulo nao pode conter apenas 2 nomes';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                autocorrect: true,
              ),
              Text(
                style: TextStyle(height: 2),
                'Descrição',
                textScaler: TextScaler.linear(1.5),
              ),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'não pode ser vazio';
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
              Switch(
                activeColor: Colors.green,
                activeTrackColor: Colors.blue,
                value: isSet,
                onChanged: (value) {
                  setState(() {
                    isSet = !isSet;
                  });
                },
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: validadeForm,
                      child: Text('salvar '),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void validadeForm() {
    if (_keyform.currentState!.validate()) {
      String tittle = tittleController.text;
      String description = descriptionController.text;
      TaskModelDoIt repo = TaskModelDoIt(
        title: tittle,
        description: description,
        status: isSet ? TaskStatus.inProgress : TaskStatus.pending,
      );
      Navigator.pop(context, repo);
    }
  }
}
