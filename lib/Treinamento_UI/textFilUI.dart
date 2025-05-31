import 'package:flutter/material.dart';

class TextFilUi extends StatefulWidget {
  const TextFilUi({Key? key}) : super(key: key);

  @override
  _TextFilUiState createState() => _TextFilUiState();
}

class _TextFilUiState extends State<TextFilUi> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('TextFields'))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            child: Container(
              width: 120,
              height: 60,
              child: TextField(
                cursorColor: Colors.red,
                keyboardType: TextInputType.emailAddress,
                controller: _controller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 5),
                  ),
                  labelText: 'ola ',
                  suffixIcon: Icon(Icons.abc),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  filled: true,
                  fillColor: Colors.amber,
                ),
              ),
            ),
          ),
          TextField(),
        ],
      ),
    );
  }
}
