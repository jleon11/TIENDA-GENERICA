import 'package:flutter/material.dart';
import 'package:tienda_motos/widgets/promo_card.dart';

class PromoSection extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const PromoSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔵 TÍTULO
        const Text(
          'PROMO DEL MES',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E478D),
          ),
        ),

        const SizedBox(height: 20),

        /// 🔥 SLIDER
        SizedBox(
          height: 500,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return PromoCard(
                nombre: item['nombre'],
                sku: item['sku'],
                precioAnterior: item['precioAnterior'],
                precioActual: item['precioActual'],
                imagen: item['imagen'],
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        /// ⚪ DOTS (decorativo tipo ecommerce)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == 1 ? Colors.black : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //Hola
}
