import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/widgets/product_card.dart';

class PromoSection extends StatefulWidget {
  final String titulo;
  final List<Map<String, dynamic>> items;
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
    if (width < 700) {
      return width * 0.88;
    }

    if (width < 1100) {
      return SistemaConstantes.cardNormalAncho;
    }

    return SistemaConstantes.cardNormalAncho;
  }

  List<List<Map<String, dynamic>>> dividirPaginas(
    List<Map<String, dynamic>> items,
    int cantidad,
  ) {
    final paginas = <List<Map<String, dynamic>>>[];

    for (int i = 0; i < items.length; i += cantidad) {
      final fin = (i + cantidad > items.length) ? items.length : i + cantidad;

      paginas.add(items.sublist(i, fin));
    }

    return paginas;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final itemsVista = calcularItemsPorVista(width);

    final cardWidth = calcularAnchoCard(width);

    final alto = SistemaConstantes.cardNormalAlto;

    final paginas = dividirPaginas(widget.items, itemsVista);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITULO
          Text(widget.titulo, style: SistemaConstantes.tituloSeccion),

          const SizedBox(height: SistemaConstantes.espacioMD),

          /// SLIDER
          SizedBox(
            height: alto,
            child: PageView.builder(
              controller: _pageController,
              itemCount: paginas.length,
              onPageChanged: (index) {
                setState(() {
                  paginaActual = index;
                });
              },
              itemBuilder: (context, paginaIndex) {
                final pagina = paginas[paginaIndex];

                return Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children: pagina.map((item) {
                      return SizedBox(
                        width: cardWidth,
                        height: alto,
                        child: ProductCard(
                          nombre: item['nombre'],
                          sku: item['sku'],
                          precioActual: item['precioActual'],
                          precioAnterior: item['precioAnterior'],
                          imagen: item['imagen'],
                          badgeTexto: widget.badgeTexto,
                          badgeColor: widget.badgeColor,
                          inventarioLimitado:
                              item['inventarioLimitado'] ?? false,
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
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: activo ? 18 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: activo
                        ? SistemaConstantes.colorPrimario
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
