import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/providers/carrito_provider.dart';

class HeaderTienda extends StatelessWidget {
  const HeaderTienda({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final esMovil = width < 900;

    final esTablet = width >= 900 && width < 1300;

    return Material(
      elevation: 2,
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: SistemaConstantes.anchoMaximoHeader,
          ),
          child: Container(
            height: SistemaConstantes.altoHeader,

            padding: EdgeInsets.symmetric(horizontal: esMovil ? 12 : 24),

            child: Row(
              children: [
                /// MENU
                IconButton(
                  icon: const Icon(Icons.menu, size: 28),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),

                const SizedBox(width: 10),

                /// LOGO
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    'assets/imagenes/logo-accesoriosGonzales-fondoBlanco.png',
                    height: esMovil ? 52 : 68,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(width: 18),

                /// BUSCADOR
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: SistemaConstantes.colorAzulPrimario,
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),

                    child: Row(
                      children: [
                        const SizedBox(width: 14),

                        const Icon(Icons.search, size: 20, color: Colors.grey),

                        const SizedBox(width: 10),

                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Buscar productos...',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),

                        Container(
                          height: 46,
                          width: esMovil ? 44 : 54,

                          decoration: const BoxDecoration(
                            color: SistemaConstantes.colorAzulPrimario,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(28),
                              bottomRight: Radius.circular(28),
                            ),
                          ),

                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /// FAVORITOS
                if (!esMovil)
                  _iconoHeader(icono: Icons.favorite_border, color: Colors.red),

                if (!esMovil) const SizedBox(width: 12),

                // Reemplaza el _iconoHeader del carrito por:
                Builder(
                  builder: (context) => Consumer<CarritoProvider>(
                    builder: (context, carrito, _) => GestureDetector(
                      onTap: () => Scaffold.of(context).openEndDrawer(),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.red,
                              size: 22,
                            ),
                          ),
                          if (carrito.totalItems > 0)
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  '${carrito.totalItems}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                if (esTablet) const SizedBox(width: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconoHeader({
    required IconData icono,
    required Color color,
    bool badge = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(icono, color: color, size: 22),
        ),

        if (badge)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
