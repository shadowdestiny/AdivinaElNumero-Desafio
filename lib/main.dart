
import 'package:flutter/material.dart';

/// Punto de entrada principal de la aplicación
void main() {
  runApp(const AdivinaElNumeroApp());
}

/// Widget raíz que representa la aplicación completa.
class AdivinaElNumeroApp extends StatelessWidget {
  const AdivinaElNumeroApp({super.key});

  /// Construye la estructura principal de la app con tema oscuro.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivina el Número',
      theme: ThemeData.dark(),
      home: const AdivinaGame(),
    );
  }
}

/// Página principal del juego donde se gestiona la interfaz y el estado del juego.
class AdivinaGame extends StatefulWidget {
  const AdivinaGame({super.key});

  @override
  State<AdivinaGame> createState() => _AdivinaGameState();
}

/// Estado del juego que contiene el layout y comportamiento dinámico.
class _AdivinaGameState extends State<AdivinaGame> {
  final TextEditingController _controller = TextEditingController();
  double _sliderValue = 1;
  int _intentos = 15;

  /// Retorna el nombre del nivel de dificultad según el valor del slider.
  String getLevelName(double value) {
    switch (value.toInt()) {
      case 0: return 'Fácil';
      case 1: return 'Medio';
      case 2: return 'Difícil';
      case 3: return 'Extremo';
      default: return 'Desconocido';
    }
  }

  /// Construye la interfaz visual del juego.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina el Número'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.menu),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Input de número + contador de intentos
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'Numbers',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Intentos", style: TextStyle(fontSize: 16)),
                    Text(
                      '$_intentos',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),

            // Columnas: Mayor que | Menor que | Historial
            Expanded(
              child: Row(
                children: [
                  _buildColumnBox("Mayor que", []),
                  _buildColumnBox("Menor que", []),
                  _buildColumnBox("Historial", []),
                ],
              ),
            ),

            // Selector de dificultad con Slider
            Column(
              children: [
                Text(getLevelName(_sliderValue), style: const TextStyle(fontSize: 16)),
                Slider(
                  min: 0,
                  max: 3,
                  divisions: 3,
                  value: _sliderValue,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Construye una columna con título y lista de números (scrollable).
  Widget _buildColumnBox(String title, List<int> items) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: items.map((item) {
                    return Text(
                      item.toString(),
                      style: const TextStyle(color: Colors.green),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
