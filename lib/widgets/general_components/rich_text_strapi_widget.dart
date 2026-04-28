import 'package:flutter/material.dart';

class RichTextStrapiWidget extends StatelessWidget {
  final dynamic contenido;
  final double fontSize;
  final Color color;
  final double height;

  const RichTextStrapiWidget({
    super.key,
    required this.contenido,
    this.fontSize = 15,
    this.color = Colors.black87,
    this.height = 1.8,
  });

  @override
  Widget build(BuildContext context) {
    if (contenido == null) {
      return const SizedBox();
    }

    /// Si ya viene String normal
    if (contenido is String) {
      return Text(
        contenido,
        style: TextStyle(fontSize: fontSize, color: color, height: height),
      );
    }

    /// Si viene RichText Strapi
    if (contenido is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: contenido.map<Widget>((block) {
          final children = block['children'] as List<dynamic>? ?? [];

          final texto = children.map((e) => e['text']?.toString() ?? '').join();

          if (texto.trim().isEmpty) {
            return const SizedBox(height: 10);
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Text(
              texto,
              style: TextStyle(
                fontSize: fontSize,
                color: color,
                height: height,
              ),
            ),
          );
        }).toList(),
      );
    }

    return Text(
      contenido.toString(),
      style: TextStyle(fontSize: fontSize, color: color, height: height),
    );
  }
}
