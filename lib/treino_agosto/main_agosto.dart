import 'package:flutter/material.dart';
import 'package:git_app/treino_agosto/treino_ui_tab_view.dart';

void main() {
  runApp(MainAgosto());
}

class MainAgosto extends StatefulWidget {
  const MainAgosto({super.key});

  @override
  State<MainAgosto> createState() => _MainAgostoState();
}

class _MainAgostoState extends State<MainAgosto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TreinoUiTabView(),
    );
  }
}
