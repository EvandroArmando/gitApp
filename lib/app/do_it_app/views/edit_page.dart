import 'package:flutter/material.dart';
import 'package:git_app/app/do_it_app/models/task_model_do_it.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TaskModelDoIt model;
  late String valorPassado;
  late bool isSwitch;
  TextEditingController descriptionController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    model = args[0] as TaskModelDoIt;
    isSwitch = model.status == TaskStatus.pending ? false : true;
    valorPassado = args[1] as String;
    print('Valor passado: $valorPassado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Página de Edição')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.title),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: '${model.description}',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
            Switch(
              value: isSwitch,
              onChanged: (value) {
                setState(() {
                  isSwitch = !isSwitch;
                });
              },
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: back,
                child: Text(
                  'Clique aqui',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void back() {
    final retorno = descriptionController.text;
    final TaskModelDoIt modelo = TaskModelDoIt(
      title: model.title,
      description: retorno,
      status: isSwitch ? TaskStatus.completed : model.status,
    );
    Navigator.pop(context, modelo);
  }
}
