import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/flutter_curso_avancado/controllers/counterState.dart';

void main() {
  group('group name', () {
    testWidgets("Testando Builder com change notifier", (testerWidget) async {
      await testerWidget.pumpWidget(
        MaterialApp(home: MyHomePage2(title: 'treino testWidget')),
      );
      expect(find.text('treino testWidget'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      await testerWidget.tap(find.byIcon(Icons.add));
      await testerWidget.pump();
      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });

    testWidgets("Testando ValueNotifier", (testerWidget) async {
      await testerWidget.pumpWidget(
        MaterialApp(home: ValueNotifierMyHomePage2(title: 'treino testWidget')),
      );
      expect(find.byKey(const Key(textValueKey)), findsOneWidget);
      expect(find.text('1'), findsNothing);
      await testerWidget.tap(find.byIcon(Icons.add));
      await testerWidget.pump();
      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });
  });
}

const textValueKey = '1';
const textValueNotifierKey = '0';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  @override
  Widget build(BuildContext context) {
    CounterStateGlobal changeState = CounterStateGlobal();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListenableBuilder(
        listenable: changeState,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text(
                  key: const ValueKey(textValueNotifierKey),
                  '${changeState.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeState.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ValueNotifierMyHomePage2 extends StatefulWidget {
  const ValueNotifierMyHomePage2({super.key, required this.title});
  final String title;
  @override
  _ValueNotifierMyHomePage2 createState() => _ValueNotifierMyHomePage2();
}

class _ValueNotifierMyHomePage2 extends State<ValueNotifierMyHomePage2> {
  @override
  Widget build(BuildContext context) {
    CounterValueNotifierStateGlobal changeState =
        CounterValueNotifierStateGlobal(0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: changeState,
        builder: (BuildContext context, int value, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text(
                  '$value',
                  key: const ValueKey(textValueKey),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  key: const ValueKey('increment'),
                  onPressed: () {
                    changeState.increment();
                  },
                  child: const Text('Incrementar'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeState.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterStateGlobal extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  void increment() {
    _counter++;
    notifyListeners();
  }
}

class CounterValueNotifierStateGlobal extends ValueNotifier<int> {
  CounterValueNotifierStateGlobal(super.value);

  increment() {
    value++;
  }
}
