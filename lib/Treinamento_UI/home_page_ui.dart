import 'package:flutter/material.dart';

class HomePageUi extends StatefulWidget {
  const HomePageUi({Key? key}) : super(key: key);

  @override
  _HomePageUiState createState() => _HomePageUiState();
}

class _HomePageUiState extends State<HomePageUi> {
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
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(92),
          color: Colors.blue,
        ),
        height: 190,
      ),
      persistentFooterButtons: [],
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // 🔹 Ajusta a altura do AppBar
        child: ClipPath(
          clipper: CustomAppBarClipper(), // 🔹 Recorta a parte inferior
          child: AppBar(
            title: Text("Meu App"),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
          ),
        ),
      ),
      body: _listWidge.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Mensagens"),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Captura"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notificações",
          ),
        ],
        currentIndex: _currentIndex,
        onTap: onTapNavig,
        type: BottomNavigationBarType.shifting, // 🔹 Aplica animações suaves
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        backgroundColor:
            Colors.blueAccent, // 🔹 Cor da barra muda dinamicamente
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
