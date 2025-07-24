import 'package:flutter/material.dart';

class HomeSplashDart extends StatefulWidget {
  const HomeSplashDart({Key? key}) : super(key: key);

  @override
  _HomeSplashDartState createState() => _HomeSplashDartState();
}

enum NewsCategory { all, politics, sports, technology, entertainment }

class _HomeSplashDartState extends State<HomeSplashDart>
    with SingleTickerProviderStateMixin {
  late Widget Function(BuildContext) funcao;
  final List<String> _imageAssets = const [
    'assets/images/snack-2635035.jpg',
    'assets/images/imagem3.jpg',
    'assets/images/imagem2.png',
  ];

  // Controlador para o PageView, necessário para o TabPageSelector
  late PageController _pageController;
  late TabController _tabController;
  Set<String> _select = {"1"};
  NewsCategory _selectedCategory = NewsCategory.all;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    // Inicializa o TabController com a mesma quantidade de tabs que imagens
    _tabController = TabController(length: _imageAssets.length, vsync: this);

    // Ouve as mudanças no PageView e atualiza o TabController
    _pageController.addListener(() {
      if (_pageController.page != null) {
        _tabController.index = _pageController.page!.round();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.transparent, // Torna o AppBar transparente para a imagem aparecer
        elevation: 0, // Remove a sombra
        flexibleSpace: PageView.builder(
        controller: _pageController, // Conecta o PageController
        itemCount: _imageAssets.length,
        itemBuilder: (context, index) {
            return Image.asset(
              _imageAssets[index],
              fit: BoxFit.cover, // Cobrirá a área do AppBar
            );
          },
        ),
        toolbarHeight: 100,
        title: const Text('Home Page'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Container(
              width: double.infinity,
              child: Center(
                child: TabPageSelector(
                  controller: _tabController, // O mesmo controlador do PageView
                  selectedColor:
                      Colors.white, // Cor do indicador da página selecionada
                  color: Colors.white.withOpacity(
                    0.5,
                  ), // Cor dos indicadores não selecionados
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.green),
        child: SegmentedButton<NewsCategory>(
          segments: const <ButtonSegment<NewsCategory>>[
            ButtonSegment<NewsCategory>(
              value: NewsCategory.all,
              label: Text('Todas'),
            ),
            ButtonSegment<NewsCategory>(
              value: NewsCategory.politics,
              label: Text('Política'),
            ),
            ButtonSegment<NewsCategory>(
              value: NewsCategory.sports,
              label: Text('Esportes'),
            ),
            ButtonSegment<NewsCategory>(
              value: NewsCategory.technology,
              label: Text('Tecnologia'),
            ),
            ButtonSegment<NewsCategory>(
              value: NewsCategory.entertainment,
              label: Text('Entretenimento'),
            ),
          ],
          // O 'selected' precisa de um Set, mesmo para seleção única
          selected: <NewsCategory>{_selectedCategory},
          onSelectionChanged: (Set<NewsCategory> newSelection) {
            // Como é seleção única, pegamos o primeiro (e único) elemento do Set
            if (newSelection.isNotEmpty) {
              setState(() {
                _selectedCategory = newSelection.first;
              });
            }
          },
          // Estilização personalizada (opcional)
          style: SegmentedButton.styleFrom(
            selectedForegroundColor: Colors.white,
            selectedBackgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            // Personaliza o preenchimento de cada segmento
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
