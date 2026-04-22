import 'package:flutter/material.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/sections/boletin_informativo_section.dart';
import 'package:tienda_motos/sections/footer_section.dart';
import 'package:tienda_motos/sections/product_grid_section.dart';

class ProductosPorCategoriaPage extends StatelessWidget {
  final CategoriaModel categoria;

  const ProductosPorCategoriaPage({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool esMovil = width < 900;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// CONTENIDO PRINCIPAL
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: esMovil ? 16 : 32,
                  vertical: 20,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1280),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// MIGAJA DE PAN
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              'Inicio',
                              style: TextStyle(
                                color: Color(0xFF1E478D),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Colors.grey,
                            ),

                            Text(
                              categoria.nombre,
                              style: const TextStyle(
                                color: Color(0xFF1E478D),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        /// TITULO
                        Text(
                          categoria.nombre.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E478D),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Explora nuestros productos disponibles.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),

                        const SizedBox(height: 30),

                        /// SUBCATEGORIAS
                        if (categoria.subcategorias.isNotEmpty) ...[
                          const Text(
                            'Subcategorías',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1E478D),
                            ),
                          ),

                          const SizedBox(height: 18),

                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: categoria.subcategorias
                                .map(
                                  (item) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 18,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: const Color(0xFF1E478D),
                                      ),
                                    ),
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        color: Color(0xFF1E478D),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),

                          const SizedBox(height: 40),
                        ],

                        /// PRODUCTOS
                        ProductGridSection<ProductoModel>(
                          titulo: 'PRODUCTOS DISPONIBLES',
                          items: categoria.productos,
                          filas: 3,
                          anchoItem: 260,
                          alturaItem: 430,
                          espaciado: 8,
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),

              /// FULL WIDTH
              const BoletinInformativo(),

              const SizedBox(height: 5),

              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
