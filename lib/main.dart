import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'FrontEnd/AuthUI/sign_up.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ChatsApp());
}

class ChatsApp extends StatefulWidget {
  const ChatsApp({Key? key}) : super(key: key);

  @override
  State<ChatsApp> createState() => _ChatsAppState();
}

class _ChatsAppState extends State<ChatsApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Student & College Interface",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: SignUpScreen(),
    );
  }
}
