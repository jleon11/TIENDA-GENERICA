import 'package:flutter/material.dart';

class SelectorCantidadWidget extends StatelessWidget {
  final int cantidad;
  final VoidCallback onSumar;
  final VoidCallback onRestar;

  const SelectorCantidadWidget({
    super.key,
    required this.cantidad,
    required this.onSumar,
    required this.onRestar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: onRestar,
              icon: const Icon(Icons.remove, color: Colors.grey),
            ),
          ),
          Text(
            '$cantidad',
            style: const TextStyle(
              fontSize: 19,
              color: Color(0xFF1E478D),
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: onSumar,
              icon: const Icon(Icons.add, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
