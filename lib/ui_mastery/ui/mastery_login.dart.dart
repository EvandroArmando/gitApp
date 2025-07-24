import 'package:flutter/material.dart';
import 'package:git_app/app_login/extensions/extension_string.dart';
import 'package:git_app/ui_mastery/extension/sizebox_extension.dart';
import 'package:git_app/ui_mastery/extension/strings_extension.dart';
import 'package:git_app/ui_mastery/mixins/sizebox_mixin.dart';

class MasteryLoginDart extends StatefulWidget {
  const MasteryLoginDart({Key? key}) : super(key: key);

  @override
  _MasteryLoginDartState createState() => _MasteryLoginDartState();
}

class _MasteryLoginDartState extends State<MasteryLoginDart> with Espacos {
  String email = "otalarmando@gmail.com";
  bool avancar = false;
  final _keyForm = GlobalKey<FormState>();
  final emailController = TextEditingController();
  validateForm() {
    if (_keyForm.currentState!.validate()) {
    Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('LoginMastery '),
        centerTitle: true,
        backgroundColor: Colors.amber,
        toolbarHeight: 110,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              Center(
                child: Text(
                  "Informe o  email do ${email.ocultEmailLogin()}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox().espacoLateral(12),
              TextFormField(
                style: TextStyle(color: avancar ? Colors.white : Colors.black),
                onChanged: (value) {
                  print(value);
                  if (value == email) {
                    print("sucesso");
                    setState(() {
                      avancar = !avancar;
                    });
                  } else {
                    setState(() {
                      avancar = false;
                    });
                  }
                  print(avancar);
                },
                controller: emailController,
                validator: (value) {
                  if (!value!.contains("@")) {
                    return "email não valido";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: avancar ? Colors.green : Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: avancar ? Colors.green : Colors.black,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              espacoVertical(12),
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  child: TextButton.icon(
                    onPressed: avancar ? validateForm : null,
                    label: Text("Next"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToHome() {
    Navigator.pushReplacementNamed(context, "/home_ui_mastery");
  }
}
