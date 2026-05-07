import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

class GridGenerico<T> extends StatelessWidget {
  final List<T> items;
  final int? cantidadMaxima;
  final double espaciado;
  final Widget Function(BuildContext, T) itemBuilder;
  final double? anchoMaximoContenedor;
  final int columnasDesktop; // 👈 nuevo

  const GridGenerico({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.cantidadMaxima,
    this.espaciado = 10,
    this.anchoMaximoContenedor,
    this.columnasDesktop = 3, // 👈 default 3, no rompe nada existente
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(
      context,
    ).size.width; // 👈 ancho real de pantalla

    return LayoutBuilder(
      builder: (context, constraints) {
        final anchoReal = constraints.maxWidth;

        final esMobile = SistemaConstantes.esMovil(
          screenWidth,
        ); // 👈 screenWidth
        final esTablet =
            screenWidth < SistemaConstantes.tablet; // 👈 screenWidth

        final double spacing = esMobile ? 10 : espaciado;

        final int columnas = esMobile ? 2 : columnasDesktop;

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
