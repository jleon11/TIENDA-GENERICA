import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';

import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/providers/favoritos_provider.dart';

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

  final ProductoModel producto;

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
    required this.producto,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool hover = false;

  bool get tieneDescuento =>
      widget.precioAnterior != null && widget.precioAnterior!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final esMobile = SistemaConstantes.esMovil(screenWidth);

    final cardHeight = SistemaConstantes.obtenerCardAlto(screenWidth);

    final cardWidth = SistemaConstantes.obtenerCardAncho(screenWidth);

    final double imageHeight = esMobile ? 110 : 200;

    final double titleFont = esMobile ? 14 : 17;

    final double priceFont = esMobile ? 15 : 17;

    final double buttonHeight = esMobile ? 38 : 46;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,

      child: MouseRegion(
        cursor: SystemMouseCursors.click,

        onEnter: (_) {
          if (!esMobile) {
            setState(() => hover = true);
          }
        },

        onExit: (_) {
          if (!esMobile) {
            setState(() => hover = false);
          }
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
                borderRadius: BorderRadius.circular(SistemaConstantes.radioLG),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(hover ? 0.08 : 0.035),

                    blurRadius: hover ? 24 : 14,

                    spreadRadius: -8,

                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: FCard.raw(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    esMobile ? 10 : 16,
                    esMobile ? 10 : 16,
                    esMobile ? 10 : 16,
                    esMobile ? 12 : 18,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      /// HEADER
                      Row(
                        children: [
                          if (widget.badgeTexto.trim().isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: esMobile ? 8 : 12,

                                vertical: esMobile ? 4 : 7,
                              ),

                              decoration: BoxDecoration(
                                color: widget.badgeColor,

                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Text(
                                widget.badgeTexto,

                                style: TextStyle(
                                  color: Colors.white,

                                  fontSize: esMobile ? 9 : 12,

                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                          const Spacer(),

                          Consumer<FavoritosProvider>(
                            builder: (context, favs, _) {
                              final esFav = favs.esFavorito(widget.producto.id);

                              return GestureDetector(
                                onTap: () =>
                                    favs.toggleFavorito(widget.producto),

                                child: Icon(
                                  esFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,

                                  size: esMobile ? 18 : 20,

                                  color: esFav
                                      ? Colors.red
                                      : Colors.grey.shade500,
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: esMobile ? 10 : 22),

                      /// IMAGEN
                      SizedBox(
                        height: imageHeight,

                        child: Padding(
                          padding: const EdgeInsets.all(6),

                          child: Image.network(
                            widget.imagen,

                            fit: BoxFit.contain,

                            errorBuilder: (_, __, ___) => Icon(
                              Icons.image_not_supported,

                              size: esMobile ? 40 : 60,

                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: esMobile ? 12 : 22),

                      /// TITULO
                      SizedBox(
                        height: esMobile ? 40 : 52,

                        child: Center(
                          child: Text(
                            widget.nombre,

                            maxLines: 2,

                            overflow: TextOverflow.ellipsis,

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              fontSize: titleFont,

                              fontWeight: FontWeight.w700,

                              color: SistemaConstantes.colorTexto,

                              height: 1.3,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: esMobile ? 6 : 10),

                      /// SKU
                      SizedBox(
                        height: 18,

                        child: Text(
                          widget.sku,

                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,

                          style: TextStyle(
                            fontSize: esMobile ? 10 : 12,

                            color: Colors.grey.shade600,

                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: esMobile ? 10 : 18),

                      /// AREA PRECIO
                      SizedBox(
                        height: esMobile ? 52 : 62,

                        child: Column(
                          children: [
                            if (tieneDescuento)
                              Text(
                                '₡ ${widget.precioAnterior!}',
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,

                                  color: Colors.grey.shade500,

                                  fontSize: esMobile ? 10 : 13,

                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                            if (!tieneDescuento)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,

                                    decoration: const BoxDecoration(
                                      color: Color(0xFF22C55E),

                                      shape: BoxShape.circle,
                                    ),
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    'En stock',

                                    style: TextStyle(
                                      color: Colors.grey.shade600,

                                      fontSize: esMobile ? 11 : 13,

                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                            SizedBox(height: esMobile ? 4 : 6),

                            Text(
                              '₡ ${widget.precioActual}',
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontSize: priceFont,

                                fontWeight: FontWeight.w900,

                                color: SistemaConstantes.colorAzulPrimario,

                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      /// BOTON
                      if (widget.mostrarBotonCarrito)
                        SizedBox(
                          width: double.infinity,

                          height: buttonHeight,

                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                SistemaConstantes.radioMD,
                              ),

                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,

                                end: Alignment.centerRight,

                                colors: [
                                  SistemaConstantes.colorAzulPrimario,

                                  SistemaConstantes.colorAzulPrimario
                                      .withOpacity(0.82),
                                ],
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: SistemaConstantes.colorAzulPrimario
                                      .withOpacity(0.15),

                                  blurRadius: 10,

                                  offset: const Offset(0, 4),
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

                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,

                                      color: Colors.white,

                                      size: esMobile ? 15 : 18,
                                    ),

                                    SizedBox(width: esMobile ? 5 : 8),

                                    Text(
                                      esMobile ? 'Añadir' : 'Añadir al carrito',

                                      style: TextStyle(
                                        color: Colors.white,

                                        fontWeight: FontWeight.w700,

                                        fontSize: esMobile ? 11 : 14,
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
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 350));
  }
}
