import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/Streams/stream_controller.dart';
import 'package:git_app/flutter_curso_avancado/builders/stream_builder.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Testando Streams, tela 02'),
      ),
      body: StreamNotifierBuilder(
        listen: (context, state) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Novo estado emitido')));
        },
        builderWhen: (context, previous, current) {
          debugPrint('previews :${previous}, corrent: ${current}');
          return current % 2 == 0;
        },
        streamNotifier: _streamNotifier,
        builder: (context, state) {
          return SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Valor do contador :${_streamNotifier.state}'),
                ElevatedButton(
                  onPressed: () {
                    _streamNotifier.emit((_streamNotifier.state) + 1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Incrementar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {}
}
