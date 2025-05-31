import 'package:flutter/material.dart';
import 'package:git_app/appToDoListComplete/controller/getData.dart';
import 'package:git_app/appToDoListComplete/models/imageModel.dart';

class HomeFetchData extends StatefulWidget {
  const HomeFetchData({Key? key}) : super(key: key);

  @override
  _HomeTodoListAppState createState() => _HomeTodoListAppState();
}

extension text on Text {
  String get reversed {
    return Text('ola mundo').toString();
  }
}

class _HomeTodoListAppState extends State<HomeFetchData> {
  ImageModel? imageModel;
  void fetchData() {
    getData()
        .then((value) {
          setState(() {
            imageModel = value;
          });
        })
        .catchError((error) {
          print('Error: $error');
        });
  }

  fetchData2() {
    getData2()
        .then((value) {
          print(value);
      
          setState(() {
            imageModel = ImageModel.fromJson(value);
          });
        })
        .catchError((error) {
          print('Error: $error');
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aplicativo de Lista de Tarefas')),
      body: Column(
        children: [
          const Text('Aplicativo de Lista de Tarefas'),
          Container(
            height: 200,
            width: 200,
            child:
                imageModel == null
                    ? const Center(child: CircularProgressIndicator())
                    : Image.network(imageModel!.img),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
          fetchData2();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
