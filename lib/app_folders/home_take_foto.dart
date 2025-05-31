import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class HomeTakeFoto extends StatefulWidget {
  const HomeTakeFoto({Key? key}) : super(key: key);

  @override
  _HomeTakeFotoState createState() => _HomeTakeFotoState();
}

class _HomeTakeFotoState extends State<HomeTakeFoto> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  File? imagemSelecionada;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  /// 🔹 Inicializa a câmera disponível
  Future<void> _initCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras!.first,
        ResolutionPreset.medium,
      );
      await _cameraController!.initialize();
      setState(() {});
    }
  }

  /// 📸 Captura uma imagem da câmera do dispositivo
  Future<void> _capturarComCamera() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;
    final XFile foto = await _cameraController!.takePicture();
    setState(() {
      imagemSelecionada = File(foto.path);
    });
  }

  /// 📂 Captura uma imagem usando `image_picker`
  Future<void> _capturarComImagePicker() async {
    final XFile? foto = await _picker.pickImage(source: ImageSource.camera);
    if (foto != null) {
      setState(() {
        imagemSelecionada = File(foto.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "camera",
            child: const Icon(Icons.camera),
            onPressed:
                _capturarComCamera, // 🔹 Usa `camera` para capturar imagens
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "image_picker",
            child: const Icon(Icons.photo_library),
            onPressed:
                _capturarComImagePicker, // 🔹 Usa `image_picker` para capturar imagens
          ),
        ],
      ),
      appBar: AppBar(title: const Center(child: Text('Captura de Imagens'))),
      body: Center(
        child:
            imagemSelecionada != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(imagemSelecionada!, fit: BoxFit.cover),
                )
                : _cameraController != null &&
                    _cameraController!.value.isInitialized
                ? CameraPreview(
                  _cameraController!,
                ) // 🔹 Exibe preview da câmera antes da captura
                : const Center(child: Text("Nenhuma foto encontrada.")),
      ),
    );
  }
}
