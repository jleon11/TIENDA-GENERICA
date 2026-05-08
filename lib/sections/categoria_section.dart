import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

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
    final width = MediaQuery.of(context).size.width;

    final esMovil = width < SistemaConstantes.mobile;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: esMovil ? 20 : 40),

      child: Column(
        children: [
          /// 🔥 TITULO
          Text(
            titulo.toUpperCase(),

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: esMovil ? 16 : 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E478D),
            ),
          ),

          SizedBox(height: esMovil ? 18 : 30),

          /// 🔥 ITEMS
          Wrap(
            spacing: esMovil ? 22 : espacioHorizontal,

            runSpacing: esMovil ? 18 : espacioVertical,

            alignment: WrapAlignment.center,

            children: items.map((e) => itemBuilder(e)).toList(),
          ),
        ],
      ),
    );
  }
}
