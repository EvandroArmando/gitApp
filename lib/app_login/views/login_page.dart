import 'package:flutter/material.dart';
import 'package:git_app/app_login/Interfaces/loading_state.dart';
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
  void initState() {
    repository.addListners(rebuild);
    super.initState();
  }

  @override
  void dispose() {
    repository.removeListners(rebuild);
    super.dispose();
  }

  void rebuild() {
    setState(() {});
  }

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

    void verify(BuildContext contextParaSnackBar) async {
      String email = emailController.text;
      String password = passwordController.text;
      if (email.validade()) {
        debugPrint('email valido');
      }
      if (await repository.login(name: email, password: password)) {
        navigateHome();
        return;
      }
      ScaffoldMessenger.of(
        contextParaSnackBar,
      ).showSnackBar(const SnackBar(content: Text('Erro ao fazer o login')));
      return;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Stack(
        children: [
          Column(
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
              ElevatedButton(
                onPressed: () {
                  verify(context);
                },
                child: Text('logar'),
              ),
            ],
          ),
          if (repository.state is LoadingState)
            AbsorbPointer(
              absorbing: true,
              child: Opacity(
                opacity: 0.6,
                child: Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
