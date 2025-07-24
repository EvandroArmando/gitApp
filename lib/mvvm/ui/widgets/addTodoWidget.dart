import 'package:flutter/material.dart';
import 'package:git_app/mvvm/ui/todo/viewmodel/todo_viewmode.dart';

class AddTodoWidget extends StatefulWidget {
  final TodoViewModel todoViewModel;
  const AddTodoWidget({required this.todoViewModel, Key? key})
    : super(key: key);

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final TextEditingController nameController = TextEditingController();
  final form_key = GlobalKey<FormState>();

  @override
  void initState() {
    widget.todoViewModel.addTodo.addListener(onResult);
    super.initState();
  }

  @override
  void dispose() {
    widget.todoViewModel.addTodo.removeListener(onResult);
    nameController.dispose();
    super.dispose();
  }

  void onResult() {
    if (widget.todoViewModel.addTodo.running) {
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
      Navigator.pop(context);

      if (widget.todoViewModel.addTodo.completed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("sucesso ao gravar a tarefa.."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("erro ao gravar a tarefa.."),
          ),
        );
      }
    }
  }

  void verify() {
    if (form_key.currentState!.validate()) {
      widget.todoViewModel.addTodo.execute(nameController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: IntrinsicHeight(
        child: Form(
          key: form_key,
          child: Column(
            children: [
              Row(children: [Text("Adicione novos Todos")]),
              SizedBox(height: 12),
              TextFormField(
                validator: (value) {
                  if (value!.length <= 2) {
                    return "O nome deve ser maior a 2";
                  }
                  if (value.isEmpty) {
                    return "não pode ser vazio";
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "informe a sua tarefa",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: verify,
                child: Text("Salvar!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
