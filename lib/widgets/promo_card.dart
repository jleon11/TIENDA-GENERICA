import 'package:flutter/material.dart';
import 'package:tienda_motos/widgets/general_components/hover_button.dart';

class PromoCard extends StatelessWidget {
  final String nombre;
  final String sku;
  final String precioAnterior;
  final String precioActual;
  final String imagen;

  const PromoCard({
    super.key,
    required this.nombre,
    required this.sku,
    required this.precioAnterior,
    required this.precioActual,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔴 BADGE
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.red,
              child: const Text(
                'Promo del mes',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 10),

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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),

          const SizedBox(height: 5),

          /// SKU
          Text(
            sku,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 8),

          /// 💰 PRECIO ANTERIOR
          Text(
            precioAnterior,
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 5),

          /// 💵 PRECIO ACTUAL
          Text(
            precioActual,
            style: const TextStyle(
              color: Color(0xFF1E478D),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 10),

          HoverButton(
            texto: 'Añadir al carrito',
            onPressed: () {},
            backgroundColor: Colors.transparent,
            hoverColor: Colors.red,
            textColor: Colors.red,
            hoverTextColor: Colors.white,
            borderColor: Colors.red,
            icon: Icons.shopping_cart,
          ),
        ],
      ),
    );
  }
}
