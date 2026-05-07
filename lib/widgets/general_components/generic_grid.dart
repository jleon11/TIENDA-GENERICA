import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

class GridGenerico<T> extends StatelessWidget {
  final List<T> items;

  final int? cantidadMaxima;

  final double espaciado;

  final Alignment alineacion;

  final Widget Function(BuildContext, T) itemBuilder;

  const GridGenerico({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.cantidadMaxima,
    this.espaciado = 20,
    this.alineacion = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final anchoDisponible = constraints.maxWidth;

        final esMobile = SistemaConstantes.esMovil(anchoDisponible);

        final anchoItem = SistemaConstantes.obtenerCardAncho(anchoDisponible);

        final int columnas = esMobile
            ? 2
            : ((anchoDisponible + espaciado) / (anchoItem + espaciado))
                  .floor()
                  .clamp(1, 999);

        int cantidadMostrar = items.length;

        if (cantidadMaxima != null) {
          cantidadMostrar = cantidadMaxima!.clamp(0, items.length);
        }

        final itemsFiltrados = items.take(cantidadMostrar).toList();

        return Align(
          alignment: alineacion,

          child: Wrap(
            spacing: espaciado,

            runSpacing: espaciado,

            children: itemsFiltrados.map((item) {
              return itemBuilder(context, item);
            }).toList(),
          ),
        );
      },
    );
  }
}
