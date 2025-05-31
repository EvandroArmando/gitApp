import 'package:flutter/material.dart';

class HomePageUi2 extends StatefulWidget {
  const HomePageUi2({Key? key}) : super(key: key);

  @override
  _HomePageUiState createState() => _HomePageUiState();
}

class _HomePageUiState extends State<HomePageUi2> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void onTapNavig(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _listWidge = const [
    Center(child: Text('Pagina 01')),
    Center(child: Text('Pagina 02')),
    Center(child: Text('Pagina 03')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tema Azul", style: Theme.of(context).textTheme.bodyMedium),
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.blue,
        child: Center(child: Text("Painel sempre visível")),
      ),
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            UserAccountsDrawerHeader(
              accountName: Text("Evandro Armando"),
              accountEmail: Text("otalarmando@gmail.com"),
            ),
            ListTile(
              title: Text("Estou aqui"),
              leading: Text("esquerda"),
              trailing: Text("direita"),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Configurações"),
              onTap: () {
                print("⚙️ Configurações clicadas!");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("🛒 Item adicionado ao carrinho!"),
                    action: SnackBarAction(
                      label: "Desfazer",
                      textColor: Colors.yellow,
                      onPressed: () {
                        print("🚨 Item removido!");
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          TextField(),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize:
                        MainAxisSize
                            .min, // 🔹 Faz o painel se ajustar ao conteúdo
                    children: [
                      ListTile(
                        leading: Icon(Icons.photo),
                        title: Text("Selecionar Imagem"),
                        onTap: () {
                          print("📷 Imagem selecionada!");
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.camera),
                        title: Text("Tirar Foto"),
                        onTap: () {
                          print("📸 Foto capturada!");
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text("Abrir BottomSheet"),
          ),
        ],
      ),

      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.redAccent, // 🔹 Cor muda durante a animação
          shape: CircleBorder(),
          child: Icon(Icons.favorite),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30); // 🔹 Ajusta o recorte
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 30,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
