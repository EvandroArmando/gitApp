import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewUi extends StatefulWidget {
  const PageViewUi({Key? key}) : super(key: key);

  @override
  _PageViewUiState createState() => _PageViewUiState();
}

class _PageViewUiState extends State<PageViewUi> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page view')),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              Container(child: Text("pagina01")),
              Container(child: Text("pagina02")),
              Container(child: Text("pagina03")),
            ],
          ),
          Positioned(
            bottom: 20,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 30,
              ), // 🔹 Ajusta a posição dos pontos
              child: SmoothPageIndicator(
                controller:
                    _pageController, // 🔹 Conecta os pontos ao `PageView`
                count: 3, // 🔹 Número total de páginas

                effect: ExpandingDotsEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
