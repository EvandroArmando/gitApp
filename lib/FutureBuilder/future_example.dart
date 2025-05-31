import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para decodificar JSON

// Assumindo que você tenha um modelo Post definido em 'models/post.dart'
// Para este exemplo, vamos defini-lo aqui para simplificar.
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

class FutureBuilderExample extends StatefulWidget {
  const FutureBuilderExample({Key? key}) : super(key: key);

  @override
  _FutureBuilderExampleState createState() => _FutureBuilderExampleState();
}

class _FutureBuilderExampleState extends State<FutureBuilderExample> {
  // Declare a variável Future
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    // Inicialize o future no initState
    _postsFuture = fetchPosts();
  }

  // Função para buscar posts da API
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      // Se o servidor retornar uma resposta 200 OK, analise o JSON.
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      // Se o servidor não retornar uma resposta 200 OK,
      // então lance uma exceção.
      throw Exception('Falha ao carregar posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo de FutureBuilder'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          // O future a ser "escutado"
          future: _postsFuture,
          // A função builder que lida com diferentes estados
          builder: (context, snapshot) {
            // Verifique o estado da conexão
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mostre um indicador de carregamento enquanto aguarda os dados
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Mostre uma mensagem de erro se algo deu errado
              return Text('Erro: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Se os dados estiverem disponíveis, exiba-os em um ListView
              List<Post> posts = snapshot.data!;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            posts[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(posts[index].body),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              // Caso padrão, talvez mostre nada ou uma mensagem específica
              return const Text('Nenhum post encontrado.');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Você pode acionar uma atualização definindo o future novamente
          setState(() {
            _postsFuture = fetchPosts();
          });
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Atualizar Posts',
      ),
    );
  }
}