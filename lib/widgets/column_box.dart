
import 'package:flutter/material.dart';

class ColumnBox extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool scrollToBottom;

  const ColumnBox({
    super.key,
    required this.title,
    required this.children,
    this.scrollToBottom = false,
  });

  @override
  State<ColumnBox> createState() => _ColumnBoxState();
}

class _ColumnBoxState extends State<ColumnBox> {
  final ScrollController _controller = ScrollController();

  @override
  void didUpdateWidget(ColumnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollToBottom && _controller.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      });
    }
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            SizedBox(
              height: 120,
              width: double.infinity,
              child: RawScrollbar(
                controller: _controller,
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 6,
                radius: const Radius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SingleChildScrollView(
                    controller: _controller,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.children,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
