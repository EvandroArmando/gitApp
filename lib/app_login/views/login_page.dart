import 'package:flutter/material.dart';
import 'package:git_app/app_login/extensions/extension_string.dart';
import 'package:git_app/app_login/repository/user_repository.dart';
import 'package:git_app/app_login/views/home_page_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRepository repository = UserRepository();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void navigateHome() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePageLogin();
          },
        ),
      );
    }

    void verify() {
      String email = emailController.text;
      String password = passwordController.text;
      if (email.validade()) {
        debugPrint('email valido');
      }
      if (repository.login(name: email, password: password)) {
        navigateHome();
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                label: Text('senha'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(onPressed: verify, child: Text('logar')),
        ],
      ),
    );
  }
}
