import 'package:flutter/material.dart';

enum ContentPage { red, blue, green }

class SegmentedContentScreenSplashDart extends StatefulWidget {
  const SegmentedContentScreenSplashDart({super.key});

  @override
  State<SegmentedContentScreenSplashDart> createState() =>
      _SegmentedContentScreenState();
}

class _SegmentedContentScreenState
    extends State<SegmentedContentScreenSplashDart> {
  // Estado que armazena a página (Container) atualmente selecionada
  ContentPage _currentPage = ContentPage.red; // Começa na página vermelha

  // Função para construir o Container colorido com base na seleção
  Widget _buildContentContainer(ContentPage page) {
    Color displayColor;
    String text;

    switch (page) {
      case ContentPage.red:
        displayColor = Colors.red;
        text = 'Esta é a Página Vermelha!';
        break;
      case ContentPage.blue:
        displayColor = Colors.blue;
        text = 'Esta é a Página Azul!';
        break;
      case ContentPage.green:
        displayColor = Colors.green;
        text = 'Esta é a Página Verde!';
        break;
    }

    return AnimatedContainer(
      // AnimatedContainer para transições suaves de cor e tamanho
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      color: displayColor,
      alignment: Alignment.center,
      constraints: BoxConstraints.expand(
        height:
            MediaQuery.of(context).size.height *
            0.6, // Ocupa 60% da altura da tela
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 4.0,
              color: Colors.black45,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seletor de Conteúdo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // SegmentedButton no topo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SegmentedButton<ContentPage>(
              segments: const <ButtonSegment<ContentPage>>[
                ButtonSegment<ContentPage>(
                  value: ContentPage.red,
                  label: Text('Vermelho'),
                ),
                ButtonSegment<ContentPage>(
                  value: ContentPage.blue,
                  label: Text('Azul'),
                ),
                ButtonSegment<ContentPage>(
                  value: ContentPage.green,
                  label: Text('Verde'),
                ),
              ],
              selected: <ContentPage>{
                _currentPage,
              }, // O Set com a página selecionada
              onSelectionChanged: (Set<ContentPage> newSelection) {
                setState(() {
                  // Atualiza o estado da página atual
                  if (newSelection.isNotEmpty) {
                    _currentPage = newSelection.first;
                  }
                });
              },
              // Estilo para o SegmentedButton
              style: SegmentedButton.styleFrom(
                selectedForegroundColor: Colors.white,
                selectedBackgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                // Removendo as linhas separadoras entre os cards/segmentos
                side: BorderSide(
                  color:
                      Colors
                          .transparent, // Define a cor da borda como transparente
                  width: 0, // Garante que a largura da borda seja zero
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // O Container que muda de cor e conteúdo
          // Usamos Expanded para que o Container ocupe o restante do espaço disponível
          Expanded(child: _buildContentContainer(_currentPage)),
        ],
      ),
    );
  }
}
