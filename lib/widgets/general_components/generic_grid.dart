import 'package:flutter/material.dart';

class GridGenerico<T> extends StatelessWidget {
  final List<T> items;

  final double anchoItem;
  final double alturaItem;

  final int? filas;

  final double espaciado;

  final Alignment alineacion;

  final Widget Function(BuildContext, T) itemBuilder;

  const GridGenerico({
    super.key,
    required this.items,
    required this.itemBuilder,

    this.anchoItem = 220,
    this.alturaItem = 300,

    this.filas,

    this.espaciado = 20,

    this.alineacion = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int cantidadMostrar = items.length;

        /// =====================================================
        /// CALCULAR COLUMNAS REALES DISPONIBLES
        /// =====================================================
        if (filas != null) {
          final columnas = (constraints.maxWidth / (anchoItem + espaciado))
              .floor()
              .clamp(1, 999);

          cantidadMostrar = (columnas * filas!).clamp(0, items.length);
        }

        final itemsFiltrados = items.take(cantidadMostrar).toList();

        return Align(
          alignment: alineacion,

          child: Wrap(
            spacing: espaciado,

            runSpacing: espaciado,

            children: itemsFiltrados.map((item) {
              return SizedBox(
                width: anchoItem,
                height: alturaItem,

                child: itemBuilder(context, item),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
