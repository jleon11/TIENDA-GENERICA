import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

class GridGenerico<T> extends StatelessWidget {
  final List<T> items;
  final int? cantidadMaxima;
  final double espaciado;
  final Widget Function(BuildContext, T) itemBuilder;
  final double? anchoMaximoContenedor;

  const GridGenerico({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.cantidadMaxima,
    this.espaciado = 20,
    this.anchoMaximoContenedor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final anchoReal = constraints.maxWidth;
        final anchoReferencia = anchoMaximoContenedor ?? anchoReal;

        final esMobile = SistemaConstantes.esMovil(anchoReferencia);
        final esTablet = anchoReferencia < SistemaConstantes.tablet;

        final double spacing = esMobile ? 10 : espaciado;

        // Columnas fijas por breakpoint — no calculadas
        final int columnas = esMobile
            ? 2
            : esTablet
            ? 2
            : 3;

        // Ancho de card = espacio real dividido en columnas exactas
        final double anchoCard =
            (anchoReal - spacing * (columnas - 1)) / columnas;

        final int cantidadMostrar = cantidadMaxima != null
            ? cantidadMaxima!.clamp(0, items.length)
            : items.length;

        final itemsFiltrados = items.take(cantidadMostrar).toList();

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: itemsFiltrados.map((item) {
            return SizedBox(
              width: anchoCard,
              child: itemBuilder(context, item),
            );
          }).toList(),
        );
      },
    );
  }
}
