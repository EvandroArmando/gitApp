import 'dart:async';

import 'package:flutter/material.dart';

class StreamExample2 extends StatefulWidget {
  const StreamExample2({Key? key}) : super(key: key);

  @override
  _StreamExample2State createState() => _StreamExample2State();
}

class _StreamExample2State extends State<StreamExample2> {
  Stream<int> contadorStream = Stream.periodic(Duration(seconds: 1), (value) {
    return value;
  }).take(10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Example2')),
      body: Center(
        child: StreamBuilder(
          stream: contadorStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               return Text('Valor ${snapshot.data}');
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Text('Finalizado!', style: TextStyle(fontSize: 24));
            }
          },
        ),
      ),
    );
  }
}



//exemplos
class ApiStreamPage extends StatefulWidget {
  @override
  _ApiStreamPageState createState() => _ApiStreamPageState();
}

class _ApiStreamPageState extends State<ApiStreamPage> {
  final StreamController<String> _streamController = StreamController<String>();

  void fetchData() async {
    await Future.delayed(Duration(seconds: 2)); // Simula um delay da API
    _streamController.sink.add('Dados carregados!');
    await Future.delayed(Duration(seconds: 2));
    _streamController.sink.add('Nova atualização');
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('API com StreamBuilder')),
      body: Center(
        child: StreamBuilder<String>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!, style: TextStyle(fontSize: 24));
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}