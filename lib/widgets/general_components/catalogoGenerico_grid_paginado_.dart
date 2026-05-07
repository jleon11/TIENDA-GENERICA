import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/providers/carrito_provider.dart';
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

  final List<String> opcionesOrden = const [
    'Recomendado',
    'Precio menor',
    'Precio mayor',
    'Nombre A-Z',
    'Nombre Z-A',
  ];

  String ordenSeleccionado = 'Recomendado';

  @override
  void initState() {
    super.initState();
    productosPorPagina = widget.cantidadInicial;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final productosOrdenados = _obtenerProductosOrdenados();
    final totalProductos = productosOrdenados.length;

    final totalPaginas = totalProductos == 0
        ? 1
        : (totalProductos / productosPorPagina).ceil();

    if (paginaActual > totalPaginas) {
      paginaActual = totalPaginas;
    }

    final inicio = totalProductos == 0
        ? 0
        : (paginaActual - 1) * productosPorPagina;

    final fin = totalProductos == 0
        ? 0
        : (inicio + productosPorPagina > totalProductos
              ? totalProductos
              : inicio + productosPorPagina);

    final productosPagina = totalProductos == 0
        ? <ProductoModel>[]
        : productosOrdenados.sublist(inicio, fin);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TOP BAR
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              totalProductos == 0
                  ? 'Productos: 0 de 0'
                  : 'Productos: ${inicio + 1} - $fin de $totalProductos',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// GRID
        if (productosPagina.isEmpty)
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productosPagina.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _obtenerColumnas(width),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: _aspectRatio(width),
            ),
            itemBuilder: (context, index) {
              final item = productosPagina[index];

              return Builder(
                // 👈
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
                  onTap: () {
                    GoRouter.of(ctx).go('/producto', extra: item);
                  },
                  onPressedAddAlCarrito: () {
                    ctx.read<CarritoProvider>().agregar(item);
                    Scaffold.of(ctx).openEndDrawer(); // 👈 usa ctx
                    Future.delayed(const Duration(seconds: 3), () {
                      if (ctx.mounted) Navigator.of(ctx).maybePop();
                    });
                  },
                ),
              );
            },
          ),

        const SizedBox(height: 28),

        /// PAGINADOR
        if (totalPaginas > 1)
          Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                IconButton(
                  onPressed: paginaActual > 1
                      ? () {
                          setState(() {
                            paginaActual--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                ...List.generate(totalPaginas, (index) {
                  final page = index + 1;
                  final activa = page == paginaActual;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        paginaActual = page;
                      });
                    },
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
                      ? () {
                          setState(() {
                            paginaActual++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<ProductoModel> _obtenerProductosOrdenados() {
    final lista = [...widget.productos];

    switch (ordenSeleccionado) {
      case 'Precio menor':
        lista.sort((a, b) => a.precio.compareTo(b.precio));
        break;
      case 'Precio mayor':
        lista.sort((a, b) => b.precio.compareTo(a.precio));
        break;
      case 'Nombre A-Z':
        lista.sort((a, b) => a.nombre.compareTo(b.nombre));
        break;
      case 'Nombre Z-A':
        lista.sort((a, b) => b.nombre.compareTo(a.nombre));
        break;
    }

    return lista;
  }

  int _obtenerColumnas(double width) {
    if (width < 700) return 1;
    if (width < 1100) return 2;
    return 3;
  }

  double _aspectRatio(double width) {
    if (width < 700) return 0.72;
    if (width < 1100) return 0.66;
    return 0.64;
  }

  Widget _dropdownCantidad() {
    return DropdownButton<int>(
      value: productosPorPagina,
      underline: const SizedBox(),
      items: widget.opcionesCantidad.map((e) {
        return DropdownMenuItem<int>(value: e, child: Text('$e'));
      }).toList(),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          productosPorPagina = value;
          paginaActual = 1;
        });
      },
    );
  }

  Widget _dropdownOrden() {
    return DropdownButton<String>(
      value: ordenSeleccionado,
      underline: const SizedBox(),
      items: opcionesOrden.map((e) {
        return DropdownMenuItem<String>(value: e, child: Text(e));
      }).toList(),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          ordenSeleccionado = value;
          paginaActual = 1;
        });
      },
    );
  }
}
