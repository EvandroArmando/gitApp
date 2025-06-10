import 'package:flutter/material.dart';
import 'package:git_app/app_login/views/settings_page.dart';

class HomePageLogin extends StatefulWidget {
  const HomePageLogin({Key? key}) : super(key: key);

  @override
  _HomePageLoginState createState() => _HomePageLoginState();
}

class _HomePageLoginState extends State<HomePageLogin> {
  int current_index = 0;

  final List<Widget> _screens = const [
    Text('Conteudo Principal'),
    SettingsPageLogin(),
    Text('data'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [ListTile(leading: Text('data'))]),
      ),
      body: _screens[current_index],
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
