import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/controllers/counterState.dart';
import 'package:git_app/flutter_curso_avancado/controllers/state_observer.dart';

class HomeCounterState extends StatefulWidget {
  const HomeCounterState({Key? key}) : super(key: key);

  @override
  _HomeCounterStateState createState() => _HomeCounterStateState();
}

class _HomeCounterStateState extends State<HomeCounterState> {
  final CounterState counterState = CounterState();
  final StateObserver stateObserver = StateObserver(0);

  @override
  void initState() {
    counterState.addListener(callback);
    stateObserver.addListener(callback);
    super.initState();
  }

  @override
  void dispose() {
    counterState.removeListener(callback);
    stateObserver.removeListener(callback);
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
          Container(child: Text("valor do contador ${counterState.count}")),
          Text("valor do 2 contador:${stateObserver.state}"),
          Center(
            child: ElevatedButton(
              onPressed: () {
                stateObserver.state++;
              },
              child: Text("Incrementar"),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterState.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
