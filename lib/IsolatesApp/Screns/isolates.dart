import 'package:flutter/material.dart';
import 'dart:isolate'; // Para Isolate.spawn, ReceivePort, SendPort
import 'dart:async'; // Para Future
import 'package:flutter/foundation.dart'; // Para compute

// --- FUNÇÕES DE NÍVEL SUPERIOR PARA ISOLATES ---
// Funções que serão executadas em Isolates separados DEVEM ser de nível superior (fora de qualquer classe)
// ou métodos estáticos.

// Função para simular uma tarefa computacional pesada (contagem de primos)
// Recebe um SendPort para enviar o resultado de volta ao Isolate principal.
void _computeHeavyTask(SendPort sendPort) {
  print('Isolate Secundário (HeavyTask): Iniciando tarefa pesada...');
  int primeCount = 0;
  // Este loop é intencionalmente longo para demonstrar o bloqueio da UI se não for um Isolate.
  // Pode ajustar o limite para ver o efeito.
  for (int i = 0; i < 50000000; i++) {
    if (_isPrime(i)) {
      primeCount++;
    }
  }
  print('Isolate Secundário (HeavyTask): Tarefa pesada concluída. Primos encontrados: $primeCount');
  sendPort.send(primeCount); // Envia o resultado de volta
}

// Função auxiliar para verificar se um número é primo (usada por _computeHeavyTask)
bool _isPrime(int number) {
  if (number < 2) return false;
  for (int i = 2; i * i <= number; i++) {
    if (number % i == 0) return false;
  }
  return true;
}

// Função para contar ocorrências de palavras usando Isolate.spawn.
// Recebe um Map como argumento, contendo SendPort, texto e palavra.
void countWordOccurrencesIsolate(dynamic message) {
  final Map<String, dynamic> dynamicData = message as Map<String, dynamic>;
  final SendPort sendPort = dynamicData['sendPort'] as SendPort;
  final String text = dynamicData['text'] as String;
  final String word = dynamicData['word'] as String;

  print('Isolate Secundário (Isolate.spawn): Iniciando contagem para "${word}"...');

  int count = 0;
  final List<String> words = text.toLowerCase().split(RegExp(r'\W+'));
  for (String w in words) {
    if (w == word.toLowerCase()) {
      count++;
    }
  }

  print('Isolate Secundário (Isolate.spawn): Contagem finalizada: $count');
  sendPort.send(count); // Envia o resultado de volta
}

// Função para contar ocorrências de palavras usando `compute`.
// Recebe um único Map como argumento e retorna um int.
int countWordOccurrencesCompute(Map<String, String> data) {
  final String text = data['text']!;
  final String word = data['word']!;

  print('Isolate Secundário (compute): Iniciando contagem para "${word}"...');

  int count = 0;
  final List<String> words = text.toLowerCase().split(RegExp(r'\W+'));
  for (String w in words) {
    if (w == word.toLowerCase()) {
      count++;
    }
  }

  print('Isolate Secundário (compute): Contagem finalizada: $count');
  return count; // Retorna o resultado
}

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  int _primeCount = 0;
  bool _isLoading = false;
  String _uiStatus = 'UI Fluida'; // Para mostrar que a UI não congela

  @override
  void initState() {
    super.initState();
    // Um timer para mostrar que a UI continua responsiva
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _uiStatus = 'UI Fluida (${DateTime.now().second % 2 == 0 ? '|' : '-'})';
      });
    });
  }

  Future<void> _runHeavyTaskInMainIsolate() async {
    setState(() {
      _isLoading = true;
      _primeCount = 0;
      _uiStatus = 'UI CONGELADA (calculando...)'; // Será verdadeiramente congelada
    });
    print('Isolate Principal: Iniciando tarefa pesada (vai congelar a UI)...');
    int primeCount = 0;
    // Executa a mesma tarefa pesada na thread principal (intencionalmente para demonstração)
    for (int i = 0; i < 50000000; i++) {
      if (_isPrime(i)) {
        primeCount++;
      }
    }
    setState(() {
      _primeCount = primeCount;
      _isLoading = false;
      _uiStatus = 'UI Fluida';
    });
    print('Isolate Principal: Tarefa pesada concluída.');
  }

  Future<void> _runHeavyTaskInNewIsolate() async {
    setState(() {
      _isLoading = true;
      _primeCount = 0;
    });

    final receivePort = ReceivePort(); // Criamos um porto para receber a mensagem

    try {
      // Cria o novo Isolate e passa o SendPort do nosso ReceivePort para ele
      await Isolate.spawn(_computeHeavyTask, receivePort.sendPort);

      // Escutamos a primeira (e única) mensagem que o Isolate secundário enviará
      final result = await receivePort.first;

      setState(() {
        _primeCount = result as int; // Fazemos o cast para int
        _isLoading = false;
      });
      print('Isolate Principal: Resultado recebido do Isolate Secundário: $_primeCount');
    } catch (e) {
      print('Erro ao criar ou comunicar com o Isolate: $e');
      setState(() {
        _isLoading = false;
        _primeCount = 0;
      });
    } finally {
      receivePort.close(); // Sempre feche o ReceivePort quando não for mais necessário
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolates em Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Status da UI: $_uiStatus',
              style: TextStyle(fontSize: 20, color: _isLoading ? Colors.red : Colors.green),
            ),
            const SizedBox(height: 30),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Text(
                'Primos Encontrados: $_primeCount',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _isLoading ? null : _runHeavyTaskInNewIsolate,
              child: const Text('Executar Tarefa Pesada em Novo Isolate'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _runHeavyTaskInMainIsolate,
              child: const Text('Executar Tarefa Pesada na Thread Principal (Congelará!)'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}

// --- EXEMPLO ESPECÍFICO COM ISOLATE.SPAWN ---
class IsolateSpawnExample extends StatefulWidget {
  const IsolateSpawnExample({super.key});

  @override
  State<IsolateSpawnExample> createState() => _IsolateSpawnExampleState();
}

class _IsolateSpawnExampleState extends State<IsolateSpawnExample> {
  String _longText = '''
    Flutter is Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
    Flutter is fast. Flutter is productive. Flutter is flexible.
    Developers love Flutter. Flutter makes app development fun.
    Flutter Flutter Flutter.
    Flutter Flutter Flutter.
    Flutter Flutter Flutter.
    Flutter Flutter Flutter.
    Flutter Flutter Flutter.
    Flutter Flutter Flutter.
  '''; // Texto de exemplo
  String _wordToCount = 'flutter';
  int _occurrenceCount = 0;
  bool _isLoading = false;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = _longText;
    _wordController.text = _wordToCount;
  }

  @override
  void dispose() {
    _textController.dispose();
    _wordController.dispose();
    super.dispose();
  }

  Future<void> _startCountingWithSpawn() async {
    setState(() {
      _isLoading = true;
      _occurrenceCount = 0;
    });

    final receivePort = ReceivePort(); // Nosso "ouvido" para o Isolate secundário
    final Isolate isolate = await Isolate.spawn(
      countWordOccurrencesIsolate, // Passamos a REFERÊNCIA da função
      {
        'sendPort': receivePort.sendPort, // Enviamos nosso SendPort para ele
        'text': _textController.text,
        'word': _wordController.text,
      },
    );

    // Escutamos o ReceivePort para a primeira mensagem (o resultado)
    receivePort.listen((message) {
      if (message is int) { // Garantimos que é o resultado esperado
        setState(() {
          _occurrenceCount = message;
          _isLoading = false;
        });
        print('Isolate Principal: Resultado recebido: $message');
        isolate.kill(priority: Isolate.immediate); // Matamos o Isolate após receber o resultado
        receivePort.close(); // Fechamos o ReceivePort
      }
    }, onError: (error) {
      print('Isolate Principal: Erro recebido do Isolate: $error');
      setState(() {
        _isLoading = false;
        _occurrenceCount = 0;
      });
      isolate.kill(priority: Isolate.immediate);
      receivePort.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isolate.spawn Exemplo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Texto Longo'),
              ),
            ),
            TextField(
              controller: _wordController,
              decoration: const InputDecoration(labelText: 'Palavra a Contar'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    'Ocorrências de "${_wordController.text}": $_occurrenceCount',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _startCountingWithSpawn,
              child: const Text('Contar Ocorrências (Isolate.spawn)'),
            ),
            const SizedBox(height: 20),
            // Adicione um indicador de UI responsiva
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 2 * 3.14159), // 0 to 2*PI (uma volta completa)
              duration: const Duration(seconds: 2),
              builder: (context, angle, child) {
                return Transform.rotate(
                  angle: angle,
                  child: const Icon(Icons.star, size: 50, color: Colors.amber),
                );
              },
              onEnd: () {
                // Reinicia a animação para continuar rodando
                if (mounted) setState(() {});
              },
            ),
            const Text('Esta estrela gira para mostrar UI fluida'),
          ],
        ),
      ),
    );
  }
}

// --- EXEMPLO ESPECÍFICO COM COMPUTE ---
class ComputeExample extends StatefulWidget {
  const ComputeExample({super.key});

  @override
  State<ComputeExample> createState() => _ComputeExampleState();
}

class _ComputeExampleState extends State<ComputeExample> {
  String _longText = '''
    The quick brown fox jumps over the lazy dog.
    The quick brown fox jumps over the lazy dog.
    The quick brown fox jumps over the lazy dog.
    This is a long long long long text.
    Dog dog dog.
    Flutter Flutter Flutter.
    Dart Dart Dart.
    Isolate Isolate Isolate.
    Compute Compute Compute.
    Programming Programming Programming.
  '''; // Texto de exemplo
  String _wordToCount = 'dog';
  int _occurrenceCount = 0;
  bool _isLoading = false;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = _longText;
    _wordController.text = _wordToCount;
  }

  @override
  void dispose() {
    _textController.dispose();
    _wordController.dispose();
    super.dispose();
  }

  Future<void> _startCountingWithCompute() async {
    setState(() {
      _isLoading = true;
      _occurrenceCount = 0;
    });

    try {
      // Chama a função compute
      // compute<InputType, OutputType>(funcao, argumento)
      final int count = await compute(
        countWordOccurrencesCompute, // A função a ser executada no Isolate
        {
          'text': _textController.text,
          'word': _wordController.text,
        },
      );

      setState(() {
        _occurrenceCount = count;
        _isLoading = false;
      });
      print('Isolate Principal: Resultado recebido de compute: $count');
    } catch (e) {
      print('Isolate Principal: Erro ao usar compute: $e');
      setState(() {
        _isLoading = false;
        _occurrenceCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compute Exemplo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                decoration: const InputDecoration(labelText: 'Texto Longo'),
              ),
            ),
            TextField(
              controller: _wordController,
              decoration: const InputDecoration(labelText: 'Palavra a Contar'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    'Ocorrências de "${_wordController.text}": $_occurrenceCount',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _startCountingWithCompute,
              child: const Text('Contar Ocorrências (compute)'),
            ),
            const SizedBox(height: 20),
            // Adicione um indicador de UI responsiva
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 2 * 3.14159), // 0 to 2*PI (uma volta completa)
              duration: const Duration(seconds: 2),
              builder: (context, angle, child) {
                return Transform.rotate(
                  angle: angle,
                  child: const Icon(Icons.access_alarm, size: 50, color: Colors.blueAccent),
                );
              },
              onEnd: () {
                // Reinicia a animação para continuar rodando
                if (mounted) setState(() {});
              },
            ),
            const Text('Este relógio gira para mostrar UI fluida'),
          ],
        ),
      ),
    );
  }
}