import 'package:flutter/material.dart';

class CategoriaItem extends StatelessWidget {
  final String nombre;
  final IconData icono;
  final bool activa;

  const CategoriaItem({
    super.key,
    required this.nombre,
    required this.icono,
    this.activa = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activa ? Colors.yellow : Colors.white,
            border: Border.all(color: const Color(0xFF1E478D), width: 3),
          ),
          child: Icon(icono, size: 40, color: const Color(0xFF1E478D)),
        ),
        const SizedBox(height: 10),
        Text(
          nombre,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF1E478D)),
        ),
      ],
    );
  }
}
