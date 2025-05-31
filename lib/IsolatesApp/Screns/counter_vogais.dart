import 'package:flutter/material.dart';

class CounterVogais extends StatefulWidget {
  const CounterVogais({Key? key}) : super(key: key);

  @override
  _CounterVogaisState createState() => _CounterVogaisState();
}

class _CounterVogaisState extends State<CounterVogais> {
  TextEditingController _textController = TextEditingController();
  int _vowelCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contador de vogais'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          TextFormField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Digite um texto',
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(onPressed: contarVogais, child: Text('Contar Vogais')),
          SizedBox(height: 12),
          Text('numero de vogais : ${_vowelCount}'),
        ],
      ),
    );
  }

  void contarVogais() {
    String text = _textController.text.toLowerCase();
    int countvogais = 0;
    String vogais = 'aeiouáéíóúàèìòùãõâêîôû';
    for (var i = 0; i < _textController.text.toLowerCase().length; i++) {
      if (_textController.text.contains(vogais[i])) {
        debugPrint('existe uma vogal');
        countvogais++;
        i++;
        
      }
    }
  }
}
