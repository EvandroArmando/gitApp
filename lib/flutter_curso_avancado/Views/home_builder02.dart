import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/builders/change_state_builder%202.dart';
import 'package:git_app/flutter_curso_avancado/builders/change_state_builder.dart';
import 'package:git_app/flutter_curso_avancado/controllers/counterState.dart';
import 'package:git_app/flutter_curso_avancado/controllers/state_observer.dart';

class HomeViewBuilderState2 extends StatefulWidget {
  const HomeViewBuilderState2({Key? key}) : super(key: key);

  @override
  _HomeCounterStateState createState() => _HomeCounterStateState();
}

class _HomeCounterStateState extends State<HomeViewBuilderState2> {
  StateObserver stateObserver = StateObserver(0);
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
          ChangeStateUIBuilder2(
            buildWhen: (context, state, newState) {
              print('Estado atual: ${newState}, estado anterior: $state');
              if (newState % 2 == 0) {
                return true;
              }
              return false;
            },
            observerState2: stateObserver,
            child: Center(child: Text("testando o segundo builder")),
            builder: (context, value, child) {
              return Column(
                children: [
                  child!,
                  Container(child: Text("valor do contador ${value}")),
                ],
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          stateObserver.state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
