import 'package:flutter/material.dart';
import 'package:git_app/main.dart';

class HomeChangeNotifier extends StatefulWidget {
  const HomeChangeNotifier({Key? key}) : super(key: key);

  @override
  _HomeChangeNotifierState createState() => _HomeChangeNotifierState();
}

class _HomeChangeNotifierState extends State<HomeChangeNotifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Teste Change Notifiers')),
      ),
      body: ListenableBuilder(
        builder: (context, child) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Teste Change Notifier'),
                  Switch(
                    value: themeDataController.isDarkMode,
                    onChanged: (value) {
                      themeDataController.isDarkModeF();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        listenable: themeDataController,
      ),
    );
  }
}
