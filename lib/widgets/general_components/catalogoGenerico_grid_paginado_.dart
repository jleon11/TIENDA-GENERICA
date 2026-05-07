import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/providers/carrito_provider.dart';
import 'package:tienda_motos/widgets/general_components/generic_grid.dart';
import 'package:tienda_motos/widgets/product_card.dart';

class CatalogoGridWidget extends StatefulWidget {
  final List<ProductoModel> productos;
  final List<int> opcionesCantidad;
  final int cantidadInicial;

  const CatalogoGridWidget({
    super.key,
    required this.productos,
    required this.opcionesCantidad,
    required this.cantidadInicial,
  });

  @override
  State<CatalogoGridWidget> createState() => _CatalogoGridWidgetState();
}

class _CatalogoGridWidgetState extends State<CatalogoGridWidget> {
  int paginaActual = 1;
  late int productosPorPagina;
  String ordenSeleccionado = 'Recomendado';

  final List<String> opcionesOrden = const [
    'Recomendado',
    'Precio menor',
    'Precio mayor',
    'Nombre A-Z',
    'Nombre Z-A',
  ];

  @override
  void initState() {
    super.initState();
    productosPorPagina = widget.cantidadInicial;
  }

  List<ProductoModel> get _productosOrdenados {
    final lista = [...widget.productos];
    switch (ordenSeleccionado) {
      case 'Precio menor':
        lista.sort((a, b) => a.precio.compareTo(b.precio));
      case 'Precio mayor':
        lista.sort((a, b) => b.precio.compareTo(a.precio));
      case 'Nombre A-Z':
        lista.sort((a, b) => a.nombre.compareTo(b.nombre));
      case 'Nombre Z-A':
        lista.sort((a, b) => b.nombre.compareTo(a.nombre));
    }
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final esMobile = width < 768;

    final ordenados = _productosOrdenados;
    final total = ordenados.length;
    final totalPaginas = total == 0 ? 1 : (total / productosPorPagina).ceil();

    // Corrige página si quedó fuera de rango al cambiar filtros
    if (paginaActual > totalPaginas) paginaActual = totalPaginas;

    final inicio = total == 0 ? 0 : (paginaActual - 1) * productosPorPagina;
    final fin = (inicio + productosPorPagina).clamp(0, total);
    final pagina = total == 0
        ? <ProductoModel>[]
        : ordenados.sublist(inicio, fin);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── ENCABEZADO ──────────────────────────────────────────
        esMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Ordenar:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: SistemaConstantes.colorTexto,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: _dropdownOrdenCompacto()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Mostrar:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: SistemaConstantes.colorTexto,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _dropdownCantidad(),
                      const Spacer(),
                      Text(
                        total == 0 ? '0 de 0' : '${inicio + 1}–$fin de $total',
                        style: const TextStyle(
                          fontSize: 12,
                          color: SistemaConstantes.colorGris,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 14,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Ordenar por:',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      _dropdownOrden(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Mostrar:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 8),
                          _dropdownCantidad(),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    total == 0
                        ? 'Productos: 0 de 0'
                        : 'Productos: ${inicio + 1} - $fin de $total',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),

        const SizedBox(height: 20),

        // ── GRID ────────────────────────────────────────────────
        if (pagina.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SistemaConstantes.radioMD),
              border: Border.all(color: SistemaConstantes.colorBorde),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 42,
                  color: SistemaConstantes.colorAzulPrimario,
                ),
                SizedBox(height: 12),
                Text(
                  'No hay productos para mostrar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: SistemaConstantes.colorTexto,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        else
          // ✅ Usa GridGenerico — sin aspectRatio, sin conflictos de altura
          GridGenerico<ProductoModel>(
            items: pagina,
            espaciado: 12,
            anchoMaximoContenedor: esMobile ? null : width - 210,

            itemBuilder: (ctx, item) => Builder(
              builder: (ctx) => ProductCard(
                nombre: item.nombre,
                sku: item.codigo,
                precioActual: item.precio.toStringAsFixed(2),
                precioAnterior: item.precioAnteriorValor?.toStringAsFixed(2),
                imagen: item.imagenPrincipal,
                badgeTexto: item.cardEtiqueta,
                badgeColor: item.cardColorEtiqueta,
                inventarioLimitado: item.inventarioLimitado,
                mostrarBotonCarrito: true,
                producto: item,
                onTap: () => GoRouter.of(ctx).go('/producto', extra: item),
                onPressedAddAlCarrito: () {
                  ctx.read<CarritoProvider>().agregar(item);
                  Scaffold.of(ctx).openEndDrawer();
                  Future.delayed(const Duration(seconds: 3), () {
                    if (ctx.mounted) Navigator.of(ctx).maybePop();
                  });
                },
              ),
            ),
          ),

        const SizedBox(height: 28),

        // ── PAGINADOR ───────────────────────────────────────────
        if (totalPaginas > 1)
          Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                IconButton(
                  onPressed: paginaActual > 1
                      ? () => setState(() => paginaActual--)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                ...List.generate(totalPaginas, (i) {
                  final page = i + 1;
                  final activa = page == paginaActual;
                  return InkWell(
                    onTap: () => setState(() => paginaActual = page),
                    child: Container(
                      width: 42,
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: activa
                            ? SistemaConstantes.colorSecundario
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: activa
                              ? SistemaConstantes.colorSecundario
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        '$page',
                        style: TextStyle(
                          color: activa
                              ? Colors.white
                              : SistemaConstantes.colorTexto,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  );
                }),
                IconButton(
                  onPressed: paginaActual < totalPaginas
                      ? () => setState(() => paginaActual++)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ── DROPDOWNS ───────────────────────────────────────────────

  Widget _dropdownOrdenCompacto() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: SistemaConstantes.colorBorde),
        borderRadius: BorderRadius.circular(SistemaConstantes.radioSM),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: ordenSeleccionado,
          isExpanded: true,
          icon: const Icon(Icons.expand_more, size: 18),
          style: const TextStyle(
            fontSize: 13,
            color: SistemaConstantes.colorTexto,
          ),
          items: opcionesOrden
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            if (v == null) return;
            setState(() {
              ordenSeleccionado = v;
              paginaActual = 1;
            });
          },
        ),
      ),
    );
  }

  Widget _dropdownOrden() {
    return DropdownButton<String>(
      value: ordenSeleccionado,
      underline: const SizedBox(),
      items: opcionesOrden
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          ordenSeleccionado = v;
          paginaActual = 1;
        });
      },
    );
  }

  Widget _dropdownCantidad() {
    return DropdownButton<int>(
      value: productosPorPagina,
      underline: const SizedBox(),
      items: widget.opcionesCantidad
          .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
          .toList(),
      onChanged: (v) {
        if (v == null) return;
        setState(() {
          productosPorPagina = v;
          paginaActual = 1;
        });
      },
    );
  }
}
