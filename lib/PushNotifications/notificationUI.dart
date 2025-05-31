import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationUi extends StatefulWidget {
  const NotificationUi({Key? key}) : super(key: key);

  @override
  _NotificationUiState createState() => _NotificationUiState();
}

class _NotificationUiState extends State<NotificationUi> {
  FirebaseMessaging firebase = FirebaseMessaging.instance;

  void configurarNotificacoes() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ✅ Solicita permissão para notificações
    NotificationSettings settings = await messaging.requestPermission();
    print("🔹Permissão concedida: ${settings.authorizationStatus}");

    // ✅ Obtém o token FCM do dispositivo
    String? token = await messaging.getToken();
    print("🔹 Token FCM: $token");

    // ✅ Captura mensagens quando o app está fechado e aberto via notificação
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        print(
          "🔹 O app foi aberto a partir de uma notificação: ${message.notification?.title}",
        );
      }
    });

    // ✅ Captura mensagens em Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Flushbar(
          title: message.notification!.title,
          margin: EdgeInsets.all(8),
          message: message.notification!.body,

          borderRadius: BorderRadius.circular(8),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue,
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      }
      print(message.data);
      print(
        "🔹 Mensagem recebida em Foreground: ${message.notification?.title}",
      );
      print("🔹 corpo: ${message.notification?.body}");
    });

    // ✅ Captura mensagens ao tocar na notificação e abrir o app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
        "🔹 O usuário tocou na notificação e abriu o app: ${message.notification?.title}",
      );
    });
  }

  @override
  void initState() {
    super.initState();
    configurarNotificacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Notificationss'))),
      body: Container(),
    );
  }
}
