import 'dart:async';

import 'package:flutter/material.dart';

class StreamExample extends StatefulWidget {
  const StreamExample({Key? key}) : super(key: key);

  @override
  _StreamExampleState createState() => _StreamExampleState();
}

class _StreamExampleState extends State<StreamExample> {
  ValueNotifier<int> valor = ValueNotifier(0);
  Stream<int> generateValores() async* {
    for (var i = 0; i < 100; i++) {
      await Future.delayed(Duration(seconds: 6));
      yield i;
    }
  }

  @override
  void initState() {
    generateValores().listen((data) {
        valor.value = data;
      print(data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valor,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Exemplo de streams'),
          ),
          body: Container(),
          floatingActionButton: FloatingActionButton(
            child: Text(valor.value.toString()),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
