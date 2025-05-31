import 'package:flutter/material.dart';
import 'package:git_app/flutter_curso_avancado/controllers/observer.dart';

class ChangeStateUIBuilder extends StatefulWidget {
  final Observer observer;
  final Widget? child;
  final Widget Function(BuildContext context ,Widget ? child) builder;
  ChangeStateUIBuilder({
    required this.observer,
    required this.builder,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  _ChengeStateBuilderState createState() => _ChengeStateBuilderState();
}

class _ChengeStateBuilderState extends State<ChangeStateUIBuilder> {
  @override
  void initState() {
    widget.observer.addListener(rebuild);
    super.initState();
  }

  @override
  void dispose() {
    widget.observer.removeListener(rebuild);
    super.dispose();
  }
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context,widget.child);
  }
}
