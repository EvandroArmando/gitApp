import 'dart:io'; // Necessário para a classe File

import 'package:flutter/material.dart';
import 'package:git_app/app_login/mixinsA/mixin_user.dart';
import 'package:git_app/app_login/repository/user_repository.dart';
import 'package:git_app/main.dart';
import 'package:image_picker/image_picker.dart'; // Necessário para ImagePicker e XFile

class SettingsPageLogin extends StatefulWidget {
  const SettingsPageLogin({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPageLogin> with UserMixinLogin {
  File? imagem_selecionada;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    if (userRepository.imagem.value.isNotEmpty) {
      final imagePath = userRepository.imagem.value!;
      final file = File(imagePath);
      if (file.existsSync()) {
        imagem_selecionada = file;
        debugPrint('Imagem carregada do repositório: $imagePath');
      } else {
        debugPrint('Caminho da imagem do repositório não existe: $imagePath');
        imagem_selecionada = null; // Garante que não tenhamos um File inválido
      }
    } else {
      debugPrint('Nenhum caminho de imagem salvo no repositório.');
      imagem_selecionada = null; // Limpa a imagem se o caminho for nulo/vazio
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Página de definições'),
      ),
      body: ListenableBuilder(
        listenable: userRepository.imagem,
        builder: (context, child) {
          return Column(
            children: [
              const SizedBox(height: 20), // Um pouco de espaço no topo
              // Usa um CircleAvatar com FileImage se a imagem_selecionada não for nula,
              // caso contrário, usa o CircleAvatar com a cor âmbar.
              SizedBox(
                height: 90,
                width: 90,
                child: CircleAvatar(
                  backgroundColor:
                      Colors.amber, // Cor padrão se não houver imagem
                  backgroundImage:
                      imagem_selecionada != null
                          ? FileImage(imagem_selecionada!)
                          : null, // backgroundImage aceita null
                  child:
                      imagem_selecionada == null
                          ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ) // Ícone se não houver imagem
                          : null,
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                title: const Text('Alterar foto de perfil'),
                trailing: IconButton(
                  onPressed: takePhoto,
                  icon: const Icon(Icons.photo_camera_outlined, size: 30),
                  tooltip:
                      'Tirar foto', // Adiciona um tooltip para acessibilidade
                ),
                leading: IconButton(
                  // Botão para selecionar da galeria (se desejar)
                  onPressed: pickPhotoFromGallery, // Novo método para galeria
                  icon: const Icon(Icons.photo_library_outlined, size: 30),
                  tooltip: 'Selecionar da galeria',
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Função para tirar foto com a câmera
  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? foto = await picker.pickImage(source: ImageSource.camera);
    // SOMENTE ATUALIZE O ESTADO SE UMA FOTO FOI REALMENTE SELECIONADA/TIRADA
    if (foto != null) {
      setState(() {
        imagem_selecionada = File(foto.path); // Agora foto.path não será nulo
        userRepository.imagem.value =
            foto.path; // Salva o caminho no repositório
        debugPrint(
          'Imagem selecionada da galeria e salva: ${userRepository.imagem.value}',
        );
        this.mostrarMensagens(context, 'Imagem salva com sucesso');
      });
    } else {
      debugPrint('Nenhuma foto foi tirada/selecionada.');
    }
  }

  // NOVO: Função para selecionar foto da galeria
  Future<void> pickPhotoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? foto = await picker.pickImage(source: ImageSource.gallery);

    if (foto != null) {
      setState(() {
        imagem_selecionada = File(foto.path);
        userRepository.imagem.value = foto.path;
        debugPrint(
          'Imagem selecionada da galeria e salva: ${userRepository.imagem.value}',
        );
      });
    } else {
      debugPrint('Nenhuma foto foi selecionada da galeria.');
    }
  }
}
