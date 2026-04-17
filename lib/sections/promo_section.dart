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
  final ScrollController _scrollController = ScrollController();

  int _currentDot = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_escucharScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_escucharScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _escucharScroll() {
    if (!_scrollController.hasClients) return;

    final max = _scrollController.position.maxScrollExtent;

    if (max <= 0) return;

    final porcentaje = _scrollController.offset / max;

    final paginas = _cantidadDots;

    int nuevo = (porcentaje * paginas).floor();

    if (nuevo >= paginas) {
      nuevo = paginas - 1;
    }

    if (_currentDot != nuevo) {
      setState(() {
        _currentDot = nuevo;
      });
    }
  }

  int get _cantidadDots {
    if (_itemsPorVista <= 0) return 1;

    return (widget.items.length / _itemsPorVista).ceil();
  }

  int _itemsPorVista = 4;

  void _irAPagina(int pagina) {
    if (!_scrollController.hasClients) return;

    final max = _scrollController.position.maxScrollExtent;

    final paginas = _cantidadDots;

    if (paginas <= 1) {
      _scrollController.jumpTo(0);
      return;
    }

    final destino = (pagina / (paginas - 1)) * max;

    _scrollController.animateTo(
      destino,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    const espacio = SistemaConstantes.espacioSM;

    double alto = SistemaConstantes.cardNormalAlto;

    double cardWidth = SistemaConstantes.cardNormalAncho;

    if (width < 700) {
      _itemsPorVista = 1;
      alto = SistemaConstantes.cardNormalAlto;
      cardWidth = width * 0.85;
    } else if (width < 1100) {
      _itemsPorVista = 3;
      alto = SistemaConstantes.cardNormalAlto;
      cardWidth = SistemaConstantes.cardNormalAncho;
    } else {
      _itemsPorVista = 4;
      cardWidth = SistemaConstantes.cardNormalAncho;
    }

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
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: false,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(widget.items.length, (index) {
                    final item = widget.items[index];

                    return Container(
                      width: cardWidth,
                      height: alto,
                      margin: EdgeInsets.only(
                        right: index == widget.items.length - 1 ? 0 : espacio,
                      ),
                      child: ProductCard(
                        nombre: item['nombre'],
                        sku: item['sku'],
                        precioActual: item['precioActual'],
                        precioAnterior: item['precioAnterior'],
                        imagen: item['imagen'],
                        badgeTexto: widget.badgeTexto,
                        badgeColor: widget.badgeColor,
                        inventarioLimitado: item['inventarioLimitado'] ?? false,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// DOTS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_cantidadDots, (index) {
              final activo = _currentDot == index;

              return GestureDetector(
                onTap: () => _irAPagina(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: activo ? 16 : 10,
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
