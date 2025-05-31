import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// --- FUNÇÕES DE NÍVEL SUPERIOR PARA ISOLATES ---
// Estas funções devem ser de nível superior ou estáticas!

// Função para o Isolate.spawn
void computeTaskIsolate(SendPort sendPort) {
  int primeCount = 0;
  for (int i = 0; i < 50000000; i++) {
    if (i % 2 == 0) {
      // Verifica se o número é par
      primeCount++;
    }
  }
  sendPort.send(primeCount);
  print('DEBUG: Isolate concluído com $primeCount pares encontrados.');
}

// Função para o compute
// Precisa ser de nível superior e receber o argumento diretamente
Future<int> activity(int value) async {
  int count = 0;
  print('DEBUG: Isolate (activity): Entrando no loop...');
  for (int i = 0; i < value; i++) {
    // isPar deve ser uma função de nível superior se for chamada aqui
    if (_isParGlobal(i)) {
      // Chama a versão global de isPar
      count++;
    }
  }
  print('DEBUG: Isolate (activity): Loop concluído. Contagem: $count');
  return count;
}

// Função auxiliar isPar de nível superior
bool _isParGlobal(int value) {
  return value % 2 == 0;
}

class Isolates2 extends StatefulWidget {
  const Isolates2({Key? key})
    : super(key: key); // Adicionado 'const' para boas práticas

  @override
  _Isolates2State createState() => _Isolates2State();
}

class _Isolates2State extends State<Isolates2> {
  String _cursorValue = '_';
  int _resultCount =
      0; // Renomeado para evitar confusão com 'primeCount' global
  bool _isLoading = false;
  String _loadingText = 'UI fluida';

  Timer? _uiFluidityTimer;

  // Função para processar com Isolate.spawn
  Future<void> _processWithIsolate() async {
    setState(() {
      _isLoading = true;
      _resultCount = 0;
      _loadingText = 'Processando com Isolate...';
      debugPrint('DEBUG: Isolate.spawn - Iniciando...');
    });

    final receivePort = ReceivePort();

    try {
      // Passa a função de nível superior
      final Isolate isolate = await Isolate.spawn(
        computeTaskIsolate,
        receivePort.sendPort,
      );

      // Escuta o resultado
      final result = await receivePort.first;
      setState(() {
        _resultCount = result as int;
        _isLoading = false;
        _loadingText = 'Isolate Concluído!';
      });
      debugPrint('DEBUG: Isolate.spawn - Resultado: $_resultCount');
      isolate.kill(priority: Isolate.immediate); // Opcional: mata o Isolate
    } catch (e) {
      debugPrint('DEBUG: Isolate.spawn - Erro: $e');
      setState(() {
        _resultCount = 0;
        _isLoading = false;
        _loadingText = 'Erro no Isolate!';
      });
    } finally {
      receivePort.close();
    }
  }

  // Função para o timer do cursor
  void _startUiFluidityTimer() {
    _uiFluidityTimer?.cancel();
    _uiFluidityTimer = Timer.periodic(const Duration(milliseconds: 500), (
      timer,
    ) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _cursorValue = _cursorValue == '_' ? '|' : '_';
      });
    });
  }

  // Função para processar com compute
  Future<void> _processWithCompute() async {
    setState(() {
      _isLoading = true;
      _resultCount = 0;
      _loadingText = 'Processando com Compute...';
      debugPrint('DEBUG: Compute - Iniciando...');
    });

    try {
      // Chama a função de nível superior 'activity'
      final int count = await compute(
        activity,
        500000000,
      ); // Aumentado o valor para ser perceptível
      setState(() {
        _resultCount = count;
        _isLoading = false;
        _loadingText = 'Compute Concluído!';
      });
      debugPrint('DEBUG: Compute - Resultado: $_resultCount');
    } catch (e) {
      debugPrint('DEBUG: Compute - Erro: $e');
      setState(() {
        _resultCount = 0;
        _isLoading = false;
        _loadingText = 'Erro no Compute!';
      });
    }
  }

  // Função que simula uma tarefa pesada na thread principal (vai congelar a UI)
  Future<void> _runMainTreead() async {
    setState(() {
      _resultCount = 0;
      _loadingText = 'UI CONGELADA (calculando...)';
      debugPrint(
        'DEBUG: Main Thread - setState antes do loop - _isLoading: $_isLoading, _loadingText: $_loadingText',
      );
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      int count = 0;
      debugPrint(
        'DEBUG: Main Thread - Entrando no loop (vai bloquear a UI)...',
      );
      // Este loop é grande para simular um bloqueio perceptível.
      for (int i = 0; i < 500000000; i++) {
        // 500 milhões de iterações
        if (_isParGlobal(i)) {
          // Usando a função global para consistência
          count++;
        }
      }
      _resultCount = count;
      debugPrint(
        'DEBUG: Main Thread - Saindo do loop. Pares encontrados: $_resultCount',
      );

      setState(() {
        _isLoading = false;
        _loadingText = 'UI fluida';
        debugPrint(
          'DEBUG: Main Thread - setState após o loop - _isLoading: $_isLoading, _loadingText: $_loadingText',
        );
      });
      debugPrint('DEBUG: Main Thread - Tarefa pesada concluída.');
    });
  }

  @override
  void initState() {
    super.initState();
    _startUiFluidityTimer();
  }

  @override
  void dispose() {
    _uiFluidityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tela de Isolates 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Valor do cursor: $_cursorValue'),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                    _loadingText,
                    style: TextStyle(
                      color: _isLoading ? Colors.red : Colors.green,
                      fontSize: 20,
                    ),
                  ),
              const SizedBox(height: 20),
              Text(
                'Pares Encontrados: $_resultCount',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _runMainTreead,
                child: const Text('Processar sem Isolate (Congelará!)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _processWithIsolate,
                child: const Text('Iniciar com Isolate.spawn'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _processWithCompute,
                child: const Text('Iniciar com Compute'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
