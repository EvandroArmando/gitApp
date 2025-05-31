import 'dart:async';
import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/Streams/ia_stream_notifier.dart';

class StreamBuilder<T> extends StatefulWidget {
  final IStreamNotifier<T> streamNotifier;
  const StreamBuilder({required this.streamNotifier, Key? key})
    : super(key: key);

  @override
  _StreamBuilderState<T> createState() => _StreamBuilderState<T>();
}

class _StreamBuilderState<T> extends State<StreamBuilder> {
late StreamSubscription<T> subscription;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('')), body: Container());
  }
}
