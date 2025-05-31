import 'package:flutter/material.dart';

class HomePageLogin extends StatefulWidget {
  const HomePageLogin({Key? key}) : super(key: key);

  @override
  _HomePageLoginState createState() => _HomePageLoginState();
}

class _HomePageLoginState extends State<HomePageLogin> {
  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [ListTile(leading: Text('data'))]),
      ),
      appBar: AppBar(centerTitle: true, title: const Text('Pagina Inicial')),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: current_index,
        selectedItemColor: Colors.red,

        onTap: (value) {
          setState(() {
            print('${value}');
            current_index = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'back'),
        ],
      ),
    );
  }
}
