import 'package:flutter/material.dart';
import 'package:git_app/splash_app/home_splash.dart.dart';

class SplashLoginPage extends StatefulWidget {
  const SplashLoginPage({Key? key}) : super(key: key);

  @override
  _SplashLoginPageState createState() => _SplashLoginPageState();
}

class _SplashLoginPageState extends State<SplashLoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  PageController page = PageController();

  List<Widget> p = [
    Container(
      decoration: BoxDecoration(
        color: Colors.black,

        borderRadius: BorderRadius.only(
          topRight: Radius.circular(22),
          topLeft: Radius.circular(22),
        ),
      ),
      width: 90,
      height: 90,
    ),
    Container(width: 90, height: 90, color: Colors.amberAccent),
    Container(width: 90, height: 90, color: Colors.red),
  ];

  @override
  void initState() {
    _controller = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        toolbarHeight: 180,
        title: const Text('Página de login'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: ListView(
              cacheExtent: 1000,
              addRepaintBoundaries: true,
              children: [
                TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.red,
                  dividerColor: Colors.transparent,
                  controller: _controller,
                  tabs: [
                    Tab(key: Key("teste"), child: Text("Home")),
                    Tab(key: Key("teste02"), child: Text("Home2")),
                    Tab(key: Key("teste03"), child: Text("Home2")),
                    Tab(key: Key("teste04"), child: Text("Home2")),
                    Tab(key: Key("teste05"), child: Text("Home2")),
                  ],
                ),
                Container(
                  color: Colors.amber,
                  height: 180,
                  child: TabBarView(
                    key: Key("valor01"),
                    controller: _controller,
                    children: [
                      Center(child: Text("🏠 Página Inicial")),
                      Center(child: Text("📩 Página ")),
                      Center(child: Text("📩 Página ")),
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
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeSplashDart()),
          );
        },
      ),
    );
  }
}
