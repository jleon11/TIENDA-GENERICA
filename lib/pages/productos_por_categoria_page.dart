import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/sections/boletin_informativo_section.dart';
import 'package:tienda_motos/sections/footer_section.dart';
import 'package:tienda_motos/sections/product_grid_section.dart';

class ProductosPorCategoriaPage extends StatefulWidget {
  final CategoriaModel categoria;

  const ProductosPorCategoriaPage({
    super.key,
    required this.categoria,
  });

  @override
  State<ProductosPorCategoriaPage> createState() =>
      _ProductosPorCategoriaPageState();
}

class _ProductosPorCategoriaPageState
    extends State<ProductosPorCategoriaPage> {
  String? subcategoriaSeleccionada;
  String ordenSeleccionado = 'Más recientes';

  final List<String> opcionesOrden = const [
    'Más recientes',
    'Precio: menor a mayor',
    'Precio: mayor a menor',
    'Nombre A-Z',
    'Nombre Z-A',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool esMovil =
        width < SistemaConstantes.mobile;

    final bool mostrarDrawer =
        width < 1100;

    final productosFiltrados =
        _obtenerProductosFiltrados();

    return Scaffold(
      backgroundColor:
          SistemaConstantes.colorFondo,

      endDrawer: mostrarDrawer
          ? Drawer(
              child: SafeArea(
                child: _PanelFiltrosPremium(
                  categoria: widget.categoria,
                  seleccionada:
                      subcategoriaSeleccionada,
                  onTap: (valor) {
                    setState(() {
                      subcategoriaSeleccionada =
                          valor;
                    });

                    Navigator.pop(context);
                  },
                  onLimpiar: () {
                    setState(() {
                      subcategoriaSeleccionada =
                          null;
                    });

                    Navigator.pop(context);
                  },
                ),
              ),
            )
          : null,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(
                  horizontal:
                      SistemaConstantes
                          .paddingHorizontal(
                    width,
                  ),
                  vertical: 20,
                ),

                child: Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(
                      maxWidth:
                          SistemaConstantes
                              .anchoMaximoContenido,
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        _BannerPremium(
                          categoria:
                              widget.categoria,
                          cantidad:
                              productosFiltrados
                                  .length,
                        )
                            .animate()
                            .fadeIn()
                            .slideY(
                              begin: -.15,
                            ),

                        const SizedBox(
                            height: 24),

                        _ToolbarPremium(
                          mostrarFiltros:
                              mostrarDrawer,
                          cantidad:
                              productosFiltrados
                                  .length,
                          ordenSeleccionado:
                              ordenSeleccionado,
                          opcionesOrden:
                              opcionesOrden,
                          onAbrirFiltros:
                              () {
                            Scaffold.of(
                              context,
                            ).openEndDrawer();
                          },
                          onCambiarOrden:
                              (valor) {
                            setState(() {
                              ordenSeleccionado =
                                  valor ??
                                      ordenSeleccionado;
                            });
                          },
                        ),

                        const SizedBox(
                            height: 24),

                        if (!mostrarDrawer)
                          Row(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              SizedBox(
                                width: 270,
                                child:
                                    _PanelFiltrosPremium(
                                  categoria: widget
                                      .categoria,
                                  seleccionada:
                                      subcategoriaSeleccionada,
                                  onTap:
                                      (valor) {
                                    setState(
                                      () {
                                        subcategoriaSeleccionada =
                                            valor;
                                      },
                                    );
                                  },
                                  onLimpiar:
                                      () {
                                    setState(
                                      () {
                                        subcategoriaSeleccionada =
                                            null;
                                      },
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(
                                  width: 26),

                              Expanded(
                                child:
                                    _ContenidoPremium(
                                  categoria: widget
                                      .categoria,
                                  seleccionada:
                                      subcategoriaSeleccionada,
                                  productos:
                                      productosFiltrados,
                                  esMovil:
                                      esMovil,
                                  onTap:
                                      (valor) {
                                    setState(
                                      () {
                                        subcategoriaSeleccionada =
                                            subcategoriaSeleccionada ==
                                                    valor
                                                ? null
                                                : valor;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        else
                          _ContenidoPremium(
                            categoria:
                                widget.categoria,
                            seleccionada:
                                subcategoriaSeleccionada,
                            productos:
                                productosFiltrados,
                            esMovil:
                                esMovil,
                            onTap:
                                (valor) {
                              setState(() {
                                subcategoriaSeleccionada =
                                    subcategoriaSeleccionada ==
                                            valor
                                        ? null
                                        : valor;
                              });
                            },
                          ),

                        const SizedBox(
                            height: 50),
                      ],
                    ),
                  ),
                ),
              ),

              const BoletinInformativo(),
              const SizedBox(height: 5),
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }

  List<ProductoModel> _obtenerProductosFiltrados() {
    List<ProductoModel> productos =
        List.from(
      widget.categoria.productos,
    );

    if (subcategoriaSeleccionada !=
        null) {
      final filtro =
          subcategoriaSeleccionada!
              .toLowerCase();

      productos = productos.where((
        p,
      ) {
        return p.nombre
                .toLowerCase()
                .contains(filtro) ||
            p.categoria
                .toLowerCase()
                .contains(filtro) ||
            p.marca
                .toLowerCase()
                .contains(filtro);
      }).toList();
    }

    switch (ordenSeleccionado) {
      case 'Precio: menor a mayor':
        productos.sort(
          (a, b) =>
              a.precio.compareTo(
            b.precio,
          ),
        );
        break;

      case 'Precio: mayor a menor':
        productos.sort(
          (a, b) =>
              b.precio.compareTo(
            a.precio,
          ),
        );
        break;

      case 'Nombre A-Z':
        productos.sort(
          (a, b) =>
              a.nombre.compareTo(
            b.nombre,
          ),
        );
        break;

      case 'Nombre Z-A':
        productos.sort(
          (a, b) =>
              b.nombre.compareTo(
            a.nombre,
          ),
        );
        break;
    }

    return productos;
  }
}

class _BannerPremium
    extends StatelessWidget {
  final CategoriaModel categoria;
  final int cantidad;

  const _BannerPremium({
    required this.categoria,
    required this.cantidad,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(28),

      decoration: BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            SistemaConstantes
                .colorAzulPrimario,
            SistemaConstantes
                .colorAzulSecundario,
          ],
        ),

        borderRadius:
            BorderRadius.circular(
          28,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                30,
              ),
            ),
            child: Text(
              '$cantidad productos',
              style: const TextStyle(
                color:
                    SistemaConstantes
                        .colorAzulPrimario,
                fontWeight:
                    FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            categoria.nombre
                .toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight:
                  FontWeight.w900,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Encuentra las mejores opciones en ${categoria.nombre.toLowerCase()}.',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolbarPremium
    extends StatelessWidget {
  final bool mostrarFiltros;
  final int cantidad;
  final String ordenSeleccionado;
  final List<String> opcionesOrden;
  final VoidCallback onAbrirFiltros;
  final ValueChanged<String?>
      onCambiarOrden;

  const _ToolbarPremium({
    required this.mostrarFiltros,
    required this.cantidad,
    required this.ordenSeleccionado,
    required this.opcionesOrden,
    required this.onAbrirFiltros,
    required this.onCambiarOrden,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      crossAxisAlignment:
          WrapCrossAlignment.center,
      children: [
        Text(
          '$cantidad resultados',
          style: const TextStyle(
            fontWeight:
                FontWeight.w700,
            color:
                SistemaConstantes
                    .colorTextoSuave,
          ),
        ),

        if (mostrarFiltros)
          ElevatedButton.icon(
            onPressed:
                onAbrirFiltros,
            icon: const Icon(
              Icons.tune,
              size: 18,
            ),
            label:
                const Text('Filtros'),
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  SistemaConstantes
                      .colorAzulPrimario,
              foregroundColor:
                  Colors.white,
            ),
          ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(
              14,
            ),
            border: Border.all(
              color:
                  SistemaConstantes
                      .colorBorde,
            ),
          ),

          child:
              DropdownButtonHideUnderline(
            child:
                DropdownButton2<String>(
              value:
                  ordenSeleccionado,
              items:
                  opcionesOrden.map(
                (item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                },
              ).toList(),
              onChanged:
                  onCambiarOrden,
              buttonStyleData:
                  const ButtonStyleData(
                height: 48,
                width: 230,
              ),
              dropdownStyleData:
                  DropdownStyleData(
                maxHeight: 260,
                decoration:
                    BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContenidoPremium
    extends StatelessWidget {
  final CategoriaModel categoria;
  final String? seleccionada;
  final List<ProductoModel> productos;
  final bool esMovil;
  final ValueChanged<String> onTap;

  const _ContenidoPremium({
    required this.categoria,
    required this.seleccionada,
    required this.productos,
    required this.esMovil,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        if (categoria
            .subcategorias
            .isNotEmpty) ...[
          const Text(
            'CATEGORÍAS',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.w900,
              color:
                  SistemaConstantes
                      .colorAzulPrimario,
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: categoria
                .subcategorias
                .map((item) {
              final activa =
                  seleccionada ==
                      item;

              return InkWell(
                onTap: () =>
                    onTap(item),

                borderRadius:
                    BorderRadius.circular(
                  30,
                ),

                child:
                    AnimatedContainer(
                  duration:
                      220.ms,
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal:
                        18,
                    vertical:
                        11,
                  ),
                  decoration:
                      BoxDecoration(
                    color: activa
                        ? SistemaConstantes
                            .colorAzulPrimario
                        : Colors
                            .white,
                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),
                    border:
                        Border.all(
                      color: SistemaConstantes
                          .colorAzulPrimario,
                    ),
                  ),
                  child: Text(
                    item,
                    style:
                        TextStyle(
                      color: activa
                          ? Colors
                              .white
                          : SistemaConstantes
                              .colorAzulPrimario,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 28),
        ],

        ProductGridSection<
            ProductoModel>(
          titulo:
              'PRODUCTOS DISPONIBLES',
          items: productos,
          filas: esMovil ? 1 : 2,
          anchoItem: esMovil
              ? double.infinity
              : SistemaConstantes
                  .cardNormalAncho,
          alturaItem:
              SistemaConstantes
                  .cardNormalAlto,
          espaciado: 8,
        ).animate().fadeIn(),
      ],
    );
  }
}

class _PanelFiltrosPremium
    extends StatelessWidget {
  final CategoriaModel categoria;
  final String? seleccionada;
  final ValueChanged<String> onTap;
  final VoidCallback onLimpiar;

  const _PanelFiltrosPremium({
    required this.categoria,
    required this.seleccionada,
    required this.onTap,
    required this.onLimpiar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          20,
        ),
        border: Border.all(
          color:
              SistemaConstantes
                  .colorBorde,
        ),
        boxShadow:
            SistemaConstantes
                .sombraSuave,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.tune,
                color:
                    SistemaConstantes
                        .colorAzulPrimario,
              ),
              SizedBox(width: 8),
              Text(
                'Filtros',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.w900,
                  color:
                      SistemaConstantes
                          .colorAzulPrimario,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          const Text(
            'Subcategorías',
            style: TextStyle(
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(height: 12),

          ...categoria.subcategorias
              .map((item) {
            return RadioListTile<
                String>(
              value: item,
              groupValue:
                  seleccionada,
              contentPadding:
                  EdgeInsets.zero,
              activeColor:
                  SistemaConstantes
                      .colorAzulPrimario,
              title: Text(item),
              onChanged:
                  (valor) {
                if (valor != null) {
                  onTap(valor);
                }
              },
            );
          }),

          const SizedBox(height: 14),

          SizedBox(
            width:
                double.infinity,
            child:
                OutlinedButton(
              onPressed:
                  onLimpiar,
              child: const Text(
                'Limpiar filtros',
              ),
            ),
          ),
        ],
      ),
    );
  }
}