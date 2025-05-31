import 'package:flutter/material.dart';

class MyTabBarScreen extends StatefulWidget {
  @override
  _MyTabBarScreenState createState() => _MyTabBarScreenState();
}

class _MyTabBarScreenState extends State<MyTabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController; // 🔹 Controla a navegação entre abas

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu TabBar"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text("Home")),
            Tab(child: Text("Home2")),
            Tab(child: Text("Home3")),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.red,
            height: 120,
            child: TabBarView(
              controller: _tabController, // 🔹 Liga o TabBarView ao controlador
              children: [
                Center(child: Text("🏠 Página Inicial")),
                Center(child: Text("📩 Página de Mensagens")),
                Center(child: Text("👤 Página de Perfil")),
              ],
            ),
          ),
          ...List.generate(
            2,
            (index) => Container(
              margin: EdgeInsets.all(8),
              width: 100,
              height: 100,
              color: Colors.blueAccent,
              child: Center(child: Text("Container ${index + 1}")),
            ),
          ),
          Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // 🔹 Centraliza os elementos na tela
            children: [
              Container(width: 100, height: 100, color: Colors.orange),
              SizedBox(height: 20), // 🔹 Espaço entre os elementos
              Container(width: 100, height: 100, color: Colors.purple),
            ],
          ),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceEvenly, // 🔹 Espaço igual entre elementos
            children: [
              Container(width: 80, height: 80, color: Colors.red),
              Container(width: 80, height: 80, color: Colors.blue),
              Container(width: 80, height: 80, color: Colors.green),
            ],
          ),
          Row(
            children: [
              Expanded(child: Container(height: 100, color: Colors.red)),
              Expanded(child: Container(height: 100, color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }
}
