
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/difficulty_config.dart';
import '../widgets/column_box.dart';
import '../services/history_service.dart';

class AdivinaGamePage extends StatefulWidget {
  const AdivinaGamePage({super.key});

  @override
  State<AdivinaGamePage> createState() => _AdivinaGamePageState();
}

class _AdivinaGamePageState extends State<AdivinaGamePage> {
  final TextEditingController _controller = TextEditingController();

  double _sliderValue = 0;
  int _remainingTries = 0;
  int _secretNumber = 0;
  int _max = 10;

  final List<int> _greaterThan = [];
  final List<int> _lessThan = [];
  final List<Map<String, dynamic>> _history = [];

  String _message = '';
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _resetGame();
  }

  /// Carga historial desde SharedPreferences
  void _loadHistory() async {
    final saved = await HistoryService.loadHistory();
    setState(() {
      _history.addAll(saved);
    });
  }

  /// Guarda historial en SharedPreferences
  void _saveHistory() {
    HistoryService.saveHistory(_history);
  }

  void _resetGame() {
    final config = difficultyLevels[_sliderValue.toInt()]!;
    _max = config['max'];
    _remainingTries = config['tries'];
    _secretNumber = Random().nextInt(_max) + 1;
    _greaterThan.clear();
    _lessThan.clear();
    _controller.clear();
    _message = '';
    _gameOver = false;
    setState(() {});
  }

  void _submitGuess() {
    final input = int.tryParse(_controller.text);
    if (input == null || input < 1 || input > _max) {
      setState(() => _message = 'Ingresa un número válido entre 1 y $_max');
      return;
    }

    setState(() {
      _remainingTries--;

      if (input == _secretNumber) {
        _message = '¡Correcto! El número era $_secretNumber';
        _history.add({'value': input, 'success': true});
        _saveHistory();
        _gameOver = true;
      } else {
        _history.add({'value': input, 'success': false});
        if (input > _secretNumber) {
          _greaterThan.add(input);
        } else {
          _lessThan.add(input);
        }

        if (_remainingTries == 0) {
          _message = '¡Sin intentos! El número era $_secretNumber';
          _gameOver = true;
        } else {
          _message = input > _secretNumber
              ? 'Muy alto. Intenta de nuevo.'
              : 'Muy bajo. Intenta de nuevo.';
        }

        _saveHistory();
      }

      _controller.clear();
    });
  }

  String get _currentLevelName => difficultyLevels[_sliderValue.toInt()]!['name'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adivina el Número')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    enabled: !_gameOver,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'Número (1 - $_max)',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    const Text("Intentos"),
                    Text('$_remainingTries'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ColumnBox(
                  title: "Mayor que",
                  children: _greaterThan.map((e) => Text('$e')).toList(),
                ),
                ColumnBox(
                  title: "Menor que",
                  children: _lessThan.map((e) => Text('$e')).toList(),
                ),
                ColumnBox(
                  title: "Historial",
                  children: _history.map((entry) {
                    return Text(
                      '${entry['value']}',
                      style: TextStyle(
                        color: entry['success'] ? Colors.green : Colors.red,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(_message, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: !_gameOver ? _submitGuess : _resetGame,
              child: Text(!_gameOver ? 'Adivinar' : 'Reiniciar'),
            ),
            const SizedBox(height: 12),
            Text(_currentLevelName, style: const TextStyle(fontSize: 16)),
            Slider(
              min: 0,
              max: 3,
              divisions: 3,
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                  _resetGame();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
