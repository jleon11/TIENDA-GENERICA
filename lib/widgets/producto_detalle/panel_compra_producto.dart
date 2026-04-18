import 'package:flutter/material.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/widgets/producto_detalle/precio_producto.dart';
import 'package:tienda_motos/widgets/producto_detalle/selector_cantidad.dart';

class PanelCompraProductoWidget extends StatelessWidget {
  final ProductoModel producto;
  final int cantidad;
  final VoidCallback onSumar;
  final VoidCallback onRestar;

  const PanelCompraProductoWidget({
    super.key,
    required this.producto,
    required this.cantidad,
    required this.onSumar,
    required this.onRestar,
  });

  @override
  Widget build(BuildContext context) {
    final bool mostrarEtiqueta = producto.cardEtiqueta.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Código: ${producto.codigo}',
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          producto.nombre.toUpperCase(),
          style: const TextStyle(
            fontSize: 34,
            height: 1.15,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E478D),
          ),
        ),

        if (mostrarEtiqueta) ...[
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: producto.cardColorEtiqueta,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              producto.cardEtiqueta,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],

        const SizedBox(height: 20),

        PrecioProductoWidget(producto: producto),

        const SizedBox(height: 28),

        Row(
          children: [
            Icon(
              producto.agotado ? Icons.cancel : Icons.check_circle,
              color: producto.agotado ? Colors.red : const Color(0xFF1E478D),
              size: 34,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                producto.agotado
                    ? 'Producto agotado'
                    : 'Disponible: ${producto.stock} unidades en stock',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: producto.agotado
                      ? Colors.red
                      : const Color(0xFF1E478D),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        Text(
          'Marca: ${producto.marca}',
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Categoría: ${producto.categoria}',
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
          ),
        ),

        if (producto.mostrarBotonCarrito) ...[
          const SizedBox(height: 28),
          SelectorCantidadWidget(
            cantidad: cantidad,
            onSumar: onSumar,
            onRestar: onRestar,
          ),
        ],

        const SizedBox(height: 30),

        Row(
          children: [
            if (producto.mostrarBotonCarrito)
              Expanded(
                child: SizedBox(
                  height: 58,
                  child: ElevatedButton(
                    onPressed: producto.agotado ? null : () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE51F2B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Añadir al carrito',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),

            if (producto.mostrarBotonCarrito) const SizedBox(width: 18),

            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, color: Color(0xFFE51F2B)),
                    SizedBox(width: 6),
                    Text(
                      'Añadir a tu lista',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
