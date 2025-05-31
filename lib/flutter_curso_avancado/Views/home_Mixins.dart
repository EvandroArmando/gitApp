import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/Mixins/change_state_mixin.dart';
import 'package:git_app/flutter_curso_avancado/builders/change_state_builder%202.dart';
import 'package:git_app/flutter_curso_avancado/builders/change_state_builder.dart';
import 'package:git_app/flutter_curso_avancado/controllers/changeState.dart';
import 'package:git_app/flutter_curso_avancado/controllers/counterState.dart';
import 'package:git_app/flutter_curso_avancado/controllers/state_observer.dart';

class HomeViewMixinsState2 extends StatefulWidget {
  const HomeViewMixinsState2({Key? key}) : super(key: key);

  @override
  _HomeCounterStateState createState() => _HomeCounterStateState();
}

class _HomeCounterStateState extends State<HomeViewMixinsState2>with ChangeStateMixin {
  StateObserver stateObserver = StateObserver(0);
  CounterState counterState = CounterState();
  late StateObserver<int> changeStateMixin;
  @override
  void initState() {
    addChangeState(counterState);
    changeStateMixin = addStateObserver(0);
    //addStateObserver(stateObserver);
    addChangeState(stateObserver);
    super.initState();
  }

  @override
  void dispose() {
    dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciando estado com mixin')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            heightFactor: 12,
            child: Text('valor do contador ${counterState.count}'),
          ),
          Center(
            child: Text(
              'valor do contador statebuilder: ${stateObserver.state}',
            ),
          ),
          Center(
            child: Text('valor do contador  Mixin: ${changeStateMixin.state}'),
          ),
          TextButton(
            onPressed: () {
              changeStateMixin.state++;
            },
            child: const Text('StateBuilder mixin'),
          ),

          TextButton(
            onPressed: () {
              stateObserver.state++;
            },
            child: const Text('StateBuilder'),
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
