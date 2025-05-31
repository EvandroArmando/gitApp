import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/builders/change_state_builder.dart';
import 'package:git_app/flutter_curso_avancado/controllers/counterState.dart';

class HomeViewBuilderState extends StatefulWidget {
  const HomeViewBuilderState({Key? key}) : super(key: key);

  @override
  _HomeCounterStateState createState() => _HomeCounterStateState();
}

class _HomeCounterStateState extends State<HomeViewBuilderState> {
  CounterState counterState = CounterState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        children: [
          ChangeStateUIBuilder(
            observer: counterState,
            child: Text("testando o primeiro builder"),
            builder: (context, child) {
              return Column(
                children: [
                  child!,
                  Container(
                    child: Text("valor do contador ${counterState.count}"),
                  ),
                ],
              );
            },
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: Text("Incrementar"),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
