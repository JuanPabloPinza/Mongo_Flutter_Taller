import 'package:flutter/material.dart';
import 'view/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gestión de Personas",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const PantallaLogin(),
    );
  }
}
