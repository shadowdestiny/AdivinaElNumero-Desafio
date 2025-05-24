import 'package:flutter/material.dart';

/// Widget reutilizable para mostrar listas numeradas dentro de una caja con scroll.
class ColumnBox extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ColumnBox({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            SizedBox(
              height: 120,
              child: SingleChildScrollView(
                child: Column(children: children),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
