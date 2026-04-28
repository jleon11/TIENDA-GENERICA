import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/widgets/general_components/hover_button.dart';

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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool hover = false;

  bool get tieneDescuento =>
      widget.precioAnterior != null && widget.precioAnterior!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final Color borde = hover
        ? SistemaConstantes.colorAzulPrimario
        : SistemaConstantes.colorBorde;

    final sombra = hover
        ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ]
        : [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ];

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

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,

          padding: SistemaConstantes.paddingCard,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SistemaConstantes.radioSM),
            border: Border.all(color: borde),
            boxShadow: sombra,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// TOP
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.badgeTexto.trim().isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: widget.badgeColor,
                        borderRadius: BorderRadius.circular(30),
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
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              /// IMAGEN
              Expanded(
                child: AnimatedScale(
                  scale: hover ? 1.04 : 1,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,

                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                      widget.imagen,
                      fit: BoxFit.contain,
                      /*
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;

                        return const Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                      */
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              /// SKU
              Text(
                widget.sku,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 8),

              /// NOMBRE
              SizedBox(
                height: 40,
                child: Text(
                  widget.nombre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: SistemaConstantes.colorTexto,
                    height: 1.3,
                  ),
                ),
              ),

              /// PRECIOS
              if (tieneDescuento)
                Text(
                  '₡ ${widget.precioAnterior!}',
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

              if (tieneDescuento) const SizedBox(height: 4),

              Text(
                '₡ ${widget.precioActual}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: SistemaConstantes.colorAzulPrimario,
                ),
              ),

              const SizedBox(height: 14),

              /// BOTÓN
              if (widget.mostrarBotonCarrito)
                SizedBox(
                  width: double.infinity,
                  child: HoverButton(
                    texto: 'Añadir al carrito',
                    onPressed: widget.onPressedAddAlCarrito ?? () {},
                    backgroundColor: Colors.transparent,
                    hoverColor: SistemaConstantes.colorSecundario,
                    textColor: SistemaConstantes.colorSecundario,
                    hoverTextColor: Colors.white,
                    borderColor: SistemaConstantes.colorSecundario,
                    icon: Icons.shopping_cart_outlined,
                  ),
                ),

              /*

              if (widget.inventarioLimitado)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    '⚠ Últimas unidades disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                */
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: const Duration(milliseconds: 350));
  }
}
