import 'package:flutter/material.dart';
import 'package:git_app/main.dart';

class HomeValueNotifier extends StatefulWidget {
  const HomeValueNotifier({Key? key}) : super(key: key);

  @override
  _HomeValueNotifierState createState() => _HomeValueNotifierState();
}

class _HomeValueNotifierState extends State<HomeValueNotifier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('testando value notifier')),
      body: ValueListenableBuilder(
        valueListenable: themeDataController2,
        builder: (context, value, child) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Teste Value Notifier'),
                  Switch(
                    value: themeDataController2.value,
                    onChanged: (value) {
                      themeDataController2.isDarkMode();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
