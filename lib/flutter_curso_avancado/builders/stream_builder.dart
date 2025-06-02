import 'dart:async';
import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/Streams/ia_stream_notifier.dart';

class StreamNotifierBuilder<T> extends StatefulWidget {
  final IStreamNotifier<T> streamNotifier;
  final Widget Function(BuildContext context, T state) builder;
  final void Function(BuildContext context, T state)? listen;

  final bool Function(BuildContext context, T previous, T current)? builderWhen;
  const StreamNotifierBuilder({
    required this.builderWhen,
    required this.streamNotifier,
    required this.builder,
    Key? key,
    required this.listen,
  }) : super(key: key);

  @override
  State<StreamNotifierBuilder<T>> createState() =>
      _StreamNotifierBuilderState<T>();
}

class _StreamNotifierBuilderState<T> extends State<StreamNotifierBuilder<T>> {
  late StreamSubscription<T>? _streamSubscription;
  late T _state;

  @override
  void initState() {
    _state = widget.streamNotifier.state;
    _streamSubscription = widget.streamNotifier.stream.listen((data) {
      if (isRebuild(_state, data)) {
        if (mounted) {
          widget.listen?.call(context, _state);
          rebuild();
        }
      }
      _state = data;
    });
    super.initState();
  }

  void rebuild() {
    setState(() {});
  }

  bool isRebuild(T previous, T current) {
    if (widget.builderWhen != null) {
      return widget.builderWhen!(context, previous, current);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.streamNotifier.state);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.dispose();
  }
}
