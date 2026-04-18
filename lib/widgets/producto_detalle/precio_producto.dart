import 'package:flutter/material.dart';
import 'package:tienda_motos/models/producto_model.dart';

class PrecioProductoWidget extends StatelessWidget {
  final ProductoModel producto;

  const PrecioProductoWidget({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '₡${producto.precioActual}',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFFE51F2B),
          ),
        ),

        if (producto.mostrarDescuento) ...[
          const SizedBox(height: 8),
          Text(
            'Antes: ₡${producto.precioAnterior}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
