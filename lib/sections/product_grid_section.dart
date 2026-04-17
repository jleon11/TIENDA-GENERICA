import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/widgets/general_components/generic_grid.dart';
import 'package:tienda_motos/widgets/general_components/contrato_card_producto.dart';
import 'package:tienda_motos/widgets/product_card.dart';

class ProductGridSection<T extends ContratoCardProducto>
    extends StatelessWidget {
  final String titulo;
  final List<T> items;

  final int filas;
  final double anchoItem;
  final double alturaItem;
  final double espaciado;
  final Alignment alineacion;

  const ProductGridSection({
    super.key,
    required this.titulo,
    required this.items,
    this.filas = 2,
    this.anchoItem = SistemaConstantes.cardNormalAncho,
    this.alturaItem = SistemaConstantes.cardNormalAlto,
    this.espaciado = 16,
    this.alineacion = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔵 TITULO
          Text(titulo, style: SistemaConstantes.tituloSeccion),

          const SizedBox(height: SistemaConstantes.espacioMD),

          /// 🔥 GRID SIN CONTENEDOR EXTERNO
          GridGenerico<T>(
            items: items,

            filas: filas,

            anchoItem: anchoItem,

            alturaItem: alturaItem,

            espaciado: espaciado,

            alineacion: alineacion,

            itemBuilder: (_, item) {
              return ProductCard(
                nombre: item.nombre,

                sku: item.codigo,

                precioActual: item.precioActual,

                precioAnterior: item.mostrarDescuento
                    ? item.precioAnterior
                    : null,

                imagen: item.cardImagen,

                badgeTexto: item.cardEtiqueta,

                badgeColor: item.cardColorEtiqueta,

                inventarioLimitado: item.inventarioLimitado,

                mostrarBotonCarrito: item.mostrarBotonCarrito,
                onTap: () {
                  GoRouter.of(context).go('/producto', extra: item);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
