import 'package:flutter/material.dart';
import 'package:git_app/splash_app/splash_login_page.dart';

class SpashDart extends StatefulWidget {
  const SpashDart({Key? key}) : super(key: key);

  @override
  _SpashDartState createState() => _SpashDartState();
}

class _SpashDartState extends State<SpashDart> {
  counter() async {
    for (var i = 5; i > 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      debugPrint("valor contador:$count");
      count.value--;
      print(count);
    }
    navigate();
  }

  navigate() {
    Navigator.pushReplacement(
      context,

      MaterialPageRoute(
        builder: (context) {
          return SplashLoginPage();
        },
      ),
    );
  }

  ValueNotifier<int> count = ValueNotifier(5);
  @override
  void initState() {
    counter();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash App'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(32),
            ),
            width: 40,
            height: 40,
            child: ValueListenableBuilder(
              valueListenable: count,
              builder: (context, value, child) {
                return Center(child: Text(value.toString()));
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator(color: Colors.blue)],
        ),
      ),
    );
  }
}
