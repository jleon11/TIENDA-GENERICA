import 'package:flutter/material.dart';
import 'package:tienda_motos/widgets/promo_card.dart';

class PromoSection extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const PromoSection({super.key, required this.items});

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

  void _escucharScroll() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final max = _scrollController.position.maxScrollExtent;

    if (max <= 0) {
      if (_currentDot != 0) {
        setState(() => _currentDot = 0);
      }
      return;
    }

    final porcentaje = offset / max;

    int nuevoDot = 0;
    if (porcentaje < 0.33) {
      nuevoDot = 0;
    } else if (porcentaje < 0.66) {
      nuevoDot = 1;
    } else {
      nuevoDot = 2;
    }

    if (nuevoDot != _currentDot) {
      setState(() => _currentDot = nuevoDot);
    }
  }

  void _irAPosicionDot(int index) {
    if (!_scrollController.hasClients) return;

    final max = _scrollController.position.maxScrollExtent;

    double destino = 0;
    if (index == 0) {
      destino = 0;
    } else if (index == 1) {
      destino = max * 0.5;
    } else {
      destino = max;
    }

    _scrollController.animateTo(
      destino,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_escucharScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double cardWidth = 280;
    double sectionHeight = 500;

    if (width < 700) {
      cardWidth = width * 0.82;
      sectionHeight = 470;
    } else if (width < 1100) {
      cardWidth = 260;
      sectionHeight = 490;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PROMO DEL MES',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            color: Color(0xFF1E478D),
          ),
        ),
        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: SizedBox(
            height: sectionHeight,
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
                      height: sectionHeight,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: index == widget.items.length - 1
                                ? Colors.transparent
                                : const Color(0xFFE5E5E5),
                          ),
                        ),
                      ),
                      child: PromoCard(
                        nombre: item['nombre'],
                        sku: item['sku'],
                        precioAnterior: item['precioAnterior'],
                        precioActual: item['precioActual'],
                        imagen: item['imagen'],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final activo = _currentDot == index;

            return GestureDetector(
              onTap: () => _irAPosicionDot(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: activo ? 10 : 10,
                height: activo ? 10 : 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: activo ? Colors.black54 : Colors.grey.shade300,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
