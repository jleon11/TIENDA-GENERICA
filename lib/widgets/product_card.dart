import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';

import 'package:tienda_motos/constants/constantes_sistema.dart';

class ProductCard extends StatefulWidget {
  final String nombre;
  final String sku;
  final String precioActual;
  final String imagen;

  final String? precioAnterior;

  final String badgeTexto;
  final Color badgeColor;

  final bool inventarioLimitado;
  final bool mostrarBotonCarrito;

  final VoidCallback? onPressedAddAlCarrito;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.nombre,
    required this.sku,
    required this.precioActual,
    required this.imagen,
    this.precioAnterior,
    this.badgeTexto = 'Exclusivo en línea',
    this.badgeColor = SistemaConstantes.colorAzulPrimario,
    this.inventarioLimitado = false,
    this.mostrarBotonCarrito = true,
    this.onPressedAddAlCarrito,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardForuiState();
}

class _ProductCardForuiState extends State<ProductCard> {
  bool hover = false;

  bool get tieneDescuento =>
      widget.precioAnterior != null && widget.precioAnterior!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          hover = true;
        });
      },

      onExit: (_) {
        setState(() {
          hover = false;
        });
      },

      child: GestureDetector(
        onTap: widget.onTap,

        child: AnimatedScale(
          scale: hover ? 1.015 : 1,

          duration: const Duration(milliseconds: 180),

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),

            curve: Curves.easeOut,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(hover ? 0.08 : 0.04),

                  blurRadius: hover ? 28 : 18,

                  spreadRadius: -8,

                  offset: const Offset(0, 14),
                ),
              ],
            ),

            child: FCard.raw(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),

                child: Column(
                  mainAxisSize: MainAxisSize.max,

                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    /// TOP
                    Row(
                      children: [
                        if (widget.badgeTexto.trim().isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),

                            decoration: BoxDecoration(
                              color: widget.badgeColor,

                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Text(
                              widget.badgeTexto,

                              style: const TextStyle(
                                color: Colors.white,

                                fontSize: 10,

                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                        const Spacer(),

                        Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.grey.shade500,
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    /// IMAGEN
                    Center(
                      child: AnimatedScale(
                        scale: hover ? 1.04 : 1,

                        duration: const Duration(milliseconds: 220),

                        curve: Curves.easeOut,

                        child: SizedBox(
                          height: 200,

                          child: Padding(
                            padding: const EdgeInsets.all(8),

                            child: Image.network(
                              widget.imagen,

                              fit: BoxFit.contain,

                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.image_not_supported,

                                size: 60,

                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// TITULO
                    Text(
                      widget.nombre,

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 17,

                        fontWeight: FontWeight.w700,

                        color: SistemaConstantes.colorTexto,

                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// SKU
                    Text(
                      widget.sku,

                      maxLines: 1,

                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 12,

                        color: Colors.grey.shade600,

                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// PRECIO ANTERIOR
                    if (tieneDescuento)
                      Text(
                        '₡ ${widget.precioAnterior!}',

                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,

                          color: Colors.grey.shade500,

                          fontSize: 13,

                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    if (tieneDescuento) const SizedBox(height: 6),

                    if (!tieneDescuento)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                            width: 7,
                            height: 7,

                            decoration: const BoxDecoration(
                              color: Color(0xFF22C55E),
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(width: 6),

                          Text(
                            'En stock',

                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                    if (!tieneDescuento) const SizedBox(height: 6),

                    /// PRECIO
                    Text(
                      '₡ ${widget.precioActual}',

                      style: const TextStyle(
                        fontSize: 17,

                        fontWeight: FontWeight.w900,

                        color: SistemaConstantes.colorAzulPrimario,

                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// BOTON
                    /// ===============================================
                    /// OPCIÓN 1 — AZUL SÓLIDO (RECOMENDADA)
                    /// ===============================================
                    if (widget.mostrarBotonCarrito) const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 46,

                      child: Container(
                        width: double.infinity,
                        height: 46,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            SistemaConstantes.radioMD,
                          ),

                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,

                            colors: [
                              SistemaConstantes.colorAzulPrimario,

                              SistemaConstantes.colorAzulPrimario.withOpacity(
                                0.78,
                              ),
                            ],
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: SistemaConstantes.colorAzulPrimario
                                  .withOpacity(0.18),

                              blurRadius: 12,

                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),

                        child: Material(
                          color: Colors.transparent,

                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              SistemaConstantes.radioMD,
                            ),

                            onTap: widget.onPressedAddAlCarrito,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: const [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),

                                SizedBox(width: 8),

                                Text(
                                  'Añadir al carrito',

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 350));
  }
}
