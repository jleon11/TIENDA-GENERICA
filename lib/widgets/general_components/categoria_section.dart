import 'package:flutter/material.dart';

class CategoriaSection<T> extends StatelessWidget {
  final String titulo;
  final List<T> items;
  final Widget Function(T) itemBuilder;

  final double espacioHorizontal;
  final double espacioVertical;

  const CategoriaSection({
    super.key,
    required this.titulo,
    required this.items,
    required this.itemBuilder,
    this.espacioHorizontal = 40,
    this.espacioVertical = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          /// 🔥 TITULO
          Text(
            titulo.toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E478D),
            ),
          ),

          const SizedBox(height: 30),

          /// 🔥 ITEMS
          Wrap(
            spacing: espacioHorizontal,
            runSpacing: espacioVertical,
            alignment: WrapAlignment.center,
            children: items.map((e) => itemBuilder(e)).toList(),
          ),
        ],
      ),
    );
  }
}
