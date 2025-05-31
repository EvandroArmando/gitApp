import 'package:flutter/material.dart';

class FundamentalWidgets extends StatefulWidget {
  const FundamentalWidgets({Key? key}) : super(key: key);

  @override
  State<FundamentalWidgets> createState() => _FundamentalWidgetsState();
}

class _FundamentalWidgetsState extends State<FundamentalWidgets> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // 🔹 Quando atingir o final, rolar para o topo
        _scrollController.animateTo(
          0.0, // 🔹 Posição inicial (topo)
          duration: Duration(seconds: 1), // 🔹 Duração da animação
          curve: Curves.easeInOut, // 🔹 Suavização da rolagem
        );
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Auto Scroll to Top")),
      body: SingleChildScrollView(
        controller: _scrollController, // 🔹 Controlador de rolagem
        child: Column(
          children: List.generate(
            50,
            (index) => Padding(
              padding: EdgeInsets.all(16),
              child: Text("Item $index", style: TextStyle(fontSize: 20)),
            ),
          ),
        ),
      ),
    );
  }
}
