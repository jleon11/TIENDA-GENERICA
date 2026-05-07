import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/providers/carrito_provider.dart';
import 'package:tienda_motos/widgets/product_card.dart';

class PromoSection extends StatefulWidget {
  final String titulo;
  final List<ProductoModel> items;
  final String badgeTexto;
  final Color badgeColor;

  const PromoSection({
    super.key,
    required this.titulo,
    required this.items,
    this.badgeTexto = 'Producto',
    this.badgeColor = SistemaConstantes.colorSecundario,
  });

  @override
  State<PromoSection> createState() => _PromoSectionState();
}

class _PromoSectionState extends State<PromoSection> {
  late final PageController _pageController;
  int paginaActual = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int calcularItemsPorVista(double width) {
    if (width < 700) return 1;
    if (width < 1100) return 3;
    return 4;
  }

  double calcularAnchoCard(double width) {
    if (width < 700) return width * 0.88;
    return SistemaConstantes.cardNormalAncho;
  }

  List<List<ProductoModel>> dividirPaginas(
    List<ProductoModel> items,
    int cantidad,
  ) {
    final paginas = <List<ProductoModel>>[];
    for (int i = 0; i < items.length; i += cantidad) {
      final fin = (i + cantidad > items.length) ? items.length : i + cantidad;
      paginas.add(items.sublist(i, fin));
    }
    return paginas;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    final width = MediaQuery.of(context).size.width;
    final itemsVista = calcularItemsPorVista(width);
    final cardWidth = calcularAnchoCard(width);
    final alto = SistemaConstantes.cardGrandeAlto;
    final paginas = dividirPaginas(widget.items, itemsVista);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.titulo, style: SistemaConstantes.tituloSeccion),
          const SizedBox(height: SistemaConstantes.espacioMD),

          /// SLIDER
          SizedBox(
            height: alto,
            child: PageView.builder(
              controller: _pageController,
              itemCount: paginas.length,
              onPageChanged: (index) => setState(() => paginaActual = index),
              itemBuilder: (context, paginaIndex) {
                final pagina = paginas[paginaIndex];

                return Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    children: pagina.map((producto) {
                      return SizedBox(
                        width: cardWidth,
                        height: alto,

                        /// 👇 Builder para tener el Scaffold accesible
                        child: Builder(
                          builder: (ctx) => ProductCard(
                            nombre: producto.nombre,
                            sku: producto.codigo,
                            precioActual: producto.precio.toString(),
                            precioAnterior: producto.precioAnteriorValor
                                ?.toString(),
                            imagen: producto.imagenes.isNotEmpty
                                ? producto.imagenes.first
                                : '',
                            badgeTexto: widget.badgeTexto,
                            badgeColor: widget.badgeColor,
                            inventarioLimitado: producto.stock <= 3,
                            onTap: () => GoRouter.of(
                              ctx,
                            ).go('/producto', extra: producto),
                            onPressedAddAlCarrito: () {
                              ctx.read<CarritoProvider>().agregar(producto);
                              Scaffold.of(ctx).openEndDrawer();
                              Future.delayed(const Duration(seconds: 3), () {
                                if (ctx.mounted) Navigator.of(ctx).maybePop();
                              });
                            },
                            producto: producto, // 👈
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 18),

          /// DOTS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(paginas.length, (index) {
              final activo = paginaActual == index;
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: activo ? 18 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: activo
                        ? SistemaConstantes.colorAzulPrimario
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
