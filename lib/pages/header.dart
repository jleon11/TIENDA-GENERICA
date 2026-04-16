import 'package:flutter/material.dart';

class HeaderTienda extends StatelessWidget {
  const HeaderTienda({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          /// 🔥 MENU
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),

          const SizedBox(width: 15),

          /// 🔥 LOGO
          Image.asset(
            'assets/imagenes/logo-accesoriosGonzales-fondoBlanco.png',
            height: 150, // 🔥 ajustado
          ),

          const Spacer(),

          /// 🔥 BUSCADOR (LIMITADO)
          Container(
            width: 1000, // 🔥 CONTROL DEL TAMAÑO
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1E478D)),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar producto',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              ],
            ),
          ),

          const Spacer(),

          /// ❤️ FAVORITOS
          Icon(Icons.favorite_border, color: Colors.red),

          const SizedBox(width: 20),

          /// 🛒 CARRITO
          Icon(Icons.shopping_cart_outlined, color: Colors.red),
        ],
      ),
    );
  }
}
