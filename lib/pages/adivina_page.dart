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

  void _loadHistory() async {
    final saved = await HistoryService.loadHistory();
    setState(() {
      _history.addAll(saved);
    });
  }

  void _saveHistory() {
    HistoryService.saveHistory(_history);
  }

  void _resetGame() {
    final config = difficultyLevels[_sliderValue.toInt()]!;
    _max = config['max'];
    _remainingTries = config['tries'];
    _secretNumber = 1 + Random().nextInt(_max);
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
      if (_gameOver) return;

      if (input == _secretNumber) {
        _message = '¡Correcto! El número era $_secretNumber';
        _history.add({'value': input, 'success': true});
        _saveHistory();
        _gameOver = true;
        Future.delayed(const Duration(seconds: 2), () => _resetGame());
      } else {
        if (input > _secretNumber) {
          _greaterThan.add(input);
        } else {
          _lessThan.add(input);
        }

        _history.add({'value': input, 'success': false});
        _remainingTries--;

        if (_remainingTries == 0) {
          _message = '¡Sin intentos! El número era $_secretNumber';
          _gameOver = true;
          _saveHistory();
          Future.delayed(const Duration(seconds: 2), () => _resetGame());
        } else {
          _message = input > _secretNumber
              ? 'Demasiado alto. Intenta de nuevo.'
              : 'Demasiado bajo. Intenta de nuevo.';
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
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submitGuess(),
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
                  scrollToBottom: true,
                  children: _greaterThan.map((e) => Text('$e')).toList(),
                ),
                ColumnBox(
                  title: "Menor que",
                  scrollToBottom: true,
                  children: _lessThan.map((e) => Text('$e')).toList(),
                ),
                ColumnBox(
                  title: "Historial",
                  scrollToBottom: true,
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
              onPressed: !_gameOver ? _submitGuess : null,
              child: const Text('Adivinar'),
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
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () async {
                await HistoryService.clearHistory();
                setState(() {
                  _history.clear();
                });
              },
              icon: const Icon(Icons.delete),
              label: const Text("Borrar historial"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
