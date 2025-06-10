import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

mixin UserMixinLogin<T extends StatefulWidget> {
  void mostrarMensagens(BuildContext contexto, String message) {
    ScaffoldMessenger.of(
      contexto,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
