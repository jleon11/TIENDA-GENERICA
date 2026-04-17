// header.dart
import 'package:flutter/material.dart';

class HeaderTienda extends StatelessWidget {
  const HeaderTienda({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool esMovil = width < 900;
    final bool esTablet = width >= 900 && width < 1300;

    return Container(
      height: 80,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: esMovil ? 12 : 30,
      ),
      child: Row(
        children: [
          /// 🔥 MENU
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),

          const SizedBox(width: 10),

          /// 🔥 LOGO
          Image.asset(
            'assets/imagenes/logo-accesoriosGonzales-fondoBlanco.png',
            height: esMovil ? 55 : 70,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 15),

          /// 🔥 BUSCADOR RESPONSIVE
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF1E478D),
                ),
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
                        isDense: true,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 15),

          /// ❤️ FAVORITOS
          if (!esMovil)
            const Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),

          if (!esMovil) const SizedBox(width: 15),

          /// 🛒 CARRITO
          const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}