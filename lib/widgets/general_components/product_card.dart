import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String nombre;
  final String sku;
  final String precioActual;
  final String imagen;

  /// opcionales
  final String? precioAnterior;
  final String badgeTexto;
  final Color badgeColor;
  final bool mostrarBoton;
  final bool inventarioLimitado;
  final VoidCallback? onAgregarCarrito;

  const ProductCard({
    super.key,
    required this.nombre,
    required this.sku,
    required this.precioActual,
    required this.imagen,

    this.precioAnterior,
    this.badgeTexto = 'Producto',
    this.badgeColor = Colors.red,
    this.mostrarBoton = true,
    this.inventarioLimitado = false,
    this.onAgregarCarrito,
  });

  bool get tieneDescuento =>
      precioAnterior != null && precioAnterior!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
      color: Colors.white,

      child: Column(
        children: [
          /// 🔥 BADGE SUPERIOR
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              color: badgeColor,
              child: Text(
                badgeTexto,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// 🖼️ IMAGEN
          SizedBox(
            height: 170,
            child: Center(child: Image.asset(imagen, fit: BoxFit.contain)),
          ),

          const SizedBox(height: 18),

          /// 🔥 CONTENIDO
          Expanded(
            child: Column(
              children: [
                Text(
                  nombre.toUpperCase(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF1E1E1E),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  sku,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),

                const SizedBox(height: 10),

                /// PRECIO ANTERIOR
                if (tieneDescuento)
                  Text(
                    '$precioAnterior IVA Incluido',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                if (tieneDescuento) const SizedBox(height: 6),

                /// PRECIO ACTUAL
                Text(
                  '$precioActual IVA Incluido',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E478D),
                  ),
                ),

                if (inventarioLimitado)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Inventario limitado',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          /// 🔥 BOTON
          if (mostrarBoton)
            SizedBox(
              width: 175,
              height: 42,
              child: OutlinedButton(
                onPressed: onAgregarCarrito ?? () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Añadir al carrito',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
