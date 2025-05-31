import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationUiweb extends StatefulWidget {
  const NotificationUiweb({Key? key}) : super(key: key);

  @override
  _NotificationUiState createState() => _NotificationUiState();
}

class _NotificationUiState extends State<NotificationUiweb> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  void configurarNotificacoes() async {


   String? token = await FirebaseMessaging.instance.getToken(
      vapidKey:
          'BJK9jfdJnuNQHK7QlxPPSMkIhNEpY3ML1AwhJLtAY9GX7UHaKJmXfk2kgkfQ4hittdGPvJc22QGv1_M2vFqvzy0',
    );
    print("🔹 Token FCM: $token");
 
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
