import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

class GridGenerico<T> extends StatelessWidget {
  final List<T> items;

  final int? cantidadMaxima;

  final double espaciado;

  final Widget Function(BuildContext, T) itemBuilder;

  const GridGenerico({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.cantidadMaxima,
    this.espaciado = 20,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final anchoDisponible = constraints.maxWidth;

        final esMobile = SistemaConstantes.esMovil(anchoDisponible);

        final anchoItem = SistemaConstantes.obtenerCardAncho(anchoDisponible);

        final double spacing = esMobile ? 10 : espaciado;

        final int columnas = esMobile
            ? 2
            : ((anchoDisponible + spacing) / (anchoItem + spacing))
                  .floor()
                  .clamp(1, 999);

        int cantidadMostrar = items.length;

        if (cantidadMaxima != null) {
          cantidadMostrar = cantidadMaxima!.clamp(0, items.length);
        }

        final itemsFiltrados = items.take(cantidadMostrar).toList();

        return Wrap(
          spacing: spacing,

          runSpacing: spacing,

          children: itemsFiltrados.map((item) {
            return itemBuilder(context, item);
          }).toList(),
        );
      },
    );
  }
}
