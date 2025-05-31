import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/controllers/i_observer2.dart';
import 'package:git_app/flutter_curso_avancado/controllers/state_observer.dart';

class ChangeStateUIBuilder2<T> extends StatefulWidget {
  final StateObserver<T> observerState2;
  final Widget? child;
  final bool Function(BuildContext context, T state, T newState)? buildWhen;
  final Widget Function(BuildContext context, T state, Widget? child) builder;
  ChangeStateUIBuilder2({
    required this.builder,
    this.child,
    this.buildWhen,
    Key? key,
    required this.observerState2,
  }) : super(key: key);

  @override
  _ChangeStateBuilderState createState() => _ChangeStateBuilderState();
}

class _ChangeStateBuilderState<T> extends State<ChangeStateUIBuilder2<T>> {
  late T state;
  @override
  void initState() {
    widget.observerState2.addListener(rebuild);
    state = widget.observerState2.state;

    super.initState();
  }

  @override
  void dispose() {
    widget.observerState2.removeListener(rebuild);
    super.dispose();
  }

  void rebuild() {
    if (shoudRebuild()) {
    state = widget.observerState2.state;
    setState(() {
    });
    }
   
  }

  // printar só se satisfazer a condição
  bool shoudRebuild() {
    if (widget.buildWhen != null) {
      return widget.buildWhen!(context, state, widget.observerState2.state);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.observerState2.state, widget.child);
  }
}
