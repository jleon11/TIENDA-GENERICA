import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/widgets/general_components/hover_button.dart';

class ProductCard extends StatelessWidget {
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

  bool get tieneDescuento =>
      precioAnterior != null && precioAnterior!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: SistemaConstantes.paddingCard,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SistemaConstantes.radioSM),
            border: Border.all(color: SistemaConstantes.colorBorde),
            boxShadow: const [],
          ),
          child: Column(
            children: [
              /// BADGE
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    badgeTexto,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// IMAGEN
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(imagen, fit: BoxFit.contain),
                ),
              ),

              const SizedBox(height: 10),

              /// NOMBRE
              SizedBox(
                height: 34,
                child: Text(
                  nombre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: SistemaConstantes.colorTexto,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              /// SKU
              Text(
                sku,
                style: const TextStyle(
                  fontSize: 11,
                  color: SistemaConstantes.colorGris,
                ),
              ),

              const SizedBox(height: 8),

              /// PRECIO ANTERIOR
              if (tieneDescuento)
                Text(precioAnterior!, style: SistemaConstantes.precioAnterior),

              if (tieneDescuento) const SizedBox(height: 4),

              /// PRECIO ACTUAL
              Text(precioActual, style: SistemaConstantes.precio),

              const SizedBox(height: 10),

              /// BOTÓN
              if (mostrarBotonCarrito)
                SizedBox(
                  width: double.infinity,
                  child: HoverButton(
                    texto: 'Añadir al carrito',
                    onPressed: onPressedAddAlCarrito ?? () {},
                    backgroundColor: Colors.transparent,
                    hoverColor: SistemaConstantes.colorSecundario,
                    textColor: SistemaConstantes.colorSecundario,
                    hoverTextColor: Colors.white,
                    borderColor: SistemaConstantes.colorSecundario,
                    icon: Icons.shopping_cart,
                  ),
                ),

              /// INVENTARIO
              if (inventarioLimitado)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Inventario limitado',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
