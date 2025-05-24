
import 'package:flutter/material.dart';
import 'pages/adivina_page.dart';

void main() {
  runApp(const AdivinaElNumeroApp());
}

class AdivinaElNumeroApp extends StatelessWidget {
  const AdivinaElNumeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivina el Número',
      theme: ThemeData.dark(),
      home: const AdivinaGamePage(),
    );
  }
}
