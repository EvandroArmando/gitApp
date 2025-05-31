import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/Streams/stream_controller.dart';

class StreamStateView2 extends StatefulWidget {
  const StreamStateView2({Key? key}) : super(key: key);

  @override
  _StreamStateViewState createState() => _StreamStateViewState();
}

class _StreamStateViewState extends State<StreamStateView2> {
  final StreamNotifier<int> _streamNotifier = StreamNotifier(0);
  late StreamSubscription subiscription;
  @override
  void initState() {
    subiscription = _streamNotifier.stream.listen((data) {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Testando Streams, tela 02'),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Valor do contador :${_streamNotifier.state}'),
            ElevatedButton(
              onPressed: () {
                _streamNotifier.emit((_streamNotifier.state) + 1);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text('Incrementar', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    subiscription.cancel();
    super.dispose();
  }
}
