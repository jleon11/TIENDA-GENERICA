import 'package:flutter/material.dart';
import 'package:tienda_motos/widgets/general_components/hover_button.dart';

class ProductCard extends StatelessWidget {
  final String nombre;
  final String sku;
  final String precioActual;
  final String imagen;
  final String? precioAnterior; // opcional (tachado)
  final String badgeTexto; // "Exclusivo en línea", "Shopper del mes", etc.
  final Color badgeColor;
  final bool inventarioLimitado;
  final VoidCallback? onAgregarCarrito;

  const ProductCard({
    super.key,
    required this.nombre,
    required this.sku,
    required this.precioActual,
    required this.imagen,
    this.precioAnterior,
    this.badgeTexto = 'Exclusivo en línea',
    this.badgeColor = const Color(0xFF1E478D),
    this.inventarioLimitado = false,
    this.onAgregarCarrito,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔵 BADGE superior
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              color: badgeColor,
              child: Text(
                badgeTexto,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          /// 🖼️ IMAGEN
          Expanded(
            child: Center(child: Image.asset(imagen, fit: BoxFit.contain)),
          ),

          const SizedBox(height: 10),

          /// 🏷️ NOMBRE
          Text(
            nombre,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 4),

          /// SKU
          Text(
            sku,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),

          const SizedBox(height: 6),

          /// 💰 PRECIO ANTERIOR (opcional, tachado)
          if (precioAnterior != null) ...[
            Text(
              precioAnterior!,
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
          ],

          /// 💵 PRECIO ACTUAL
          Text(
            precioActual,
            style: const TextStyle(
              color: Color(0xFF1E478D),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 8),

          /// 🛒 BOTÓN
          HoverButton(
            texto: 'Añadir al carrito',
            onPressed: onAgregarCarrito ?? () {},
            backgroundColor: Colors.transparent,
            hoverColor: Colors.red,
            textColor: Colors.red,
            hoverTextColor: Colors.white,
            borderColor: Colors.red,
            icon: Icons.shopping_cart,
          ),

          /// ⚠️ INVENTARIO LIMITADO
          if (inventarioLimitado) ...[
            const SizedBox(height: 4),
            Text(
              'Inventario limitado',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
