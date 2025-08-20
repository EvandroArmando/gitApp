import 'package:flutter/material.dart';

class TreinoUiTabView extends StatefulWidget {
  const TreinoUiTabView({Key? key}) : super(key: key);

  @override
  _TreinoUiTabViewState createState() => _TreinoUiTabViewState();
}

class _TreinoUiTabViewState extends State<TreinoUiTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        toolbarHeight: 100,
        flexibleSpace: Container(width: double.infinity, color: Colors.red),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: ListView(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: TabBar(
                    labelColor: Colors.red,
                    dividerColor: Colors.transparent,
                    padding: EdgeInsets.only(left: 12, top: 2, bottom: 0),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Creates border
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ), //Change
                    controller: _tabController,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Servicos", style: TextStyle(height: 0)),
                      ),
                      Text("Produtos", style: TextStyle(height: 0)),
                      Text("Containers", style: TextStyle(height: 0)),
                    ],
                  ),
                ),

                Container(
                  color: Colors.amber,
                  height: 180,
                  child: TabBarView(
                    key: Key("valor01"),
                    controller: _tabController,
                    children: [
                      Center(child: Text("🏠 Página Inicial")),
                      Center(child: Text("📩 Página ")),
                      Center(child: Text("📩 Página ")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Container(),
    );
  }
}
