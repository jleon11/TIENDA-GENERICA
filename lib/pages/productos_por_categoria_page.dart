import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/sections/boletin_informativo_section.dart';
import 'package:tienda_motos/sections/footer_section.dart';
import 'package:tienda_motos/widgets/general_components/catalogoGenerico_grid_paginado_.dart';

class ProductosPorCategoriaPage extends StatefulWidget {
  final CategoriaModel categoria;

  const ProductosPorCategoriaPage({super.key, required this.categoria});

  @override
  State<ProductosPorCategoriaPage> createState() =>
      _ProductosPorCategoriaPageState();
}

class _ProductosPorCategoriaPageState extends State<ProductosPorCategoriaPage> {
  String? subcategoriaSeleccionada;

  final List<int> opcionesCantidad = const [15, 25, 50];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final esMovil = width < 900;
    final productos = _obtenerProductosFiltrados();

    return Scaffold(
      backgroundColor: SistemaConstantes.colorFondo,
      endDrawer: esMovil ? _drawerSectionFiltrosMobile() : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SistemaConstantes.paddingHorizontal(width),
                  vertical: esMovil ? 14 : 22,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: SistemaConstantes.anchoMaximoContenido,
                    ),
                    child: esMovil
                        ? _layoutMovil(productos)
                        : _layoutDesktop(productos),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const BoletinInformativo(),

              const SizedBox(height: 8),

              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }

  /// ===============================
  /// MOBILE
  /// ===============================
  Widget _layoutMovil(List<ProductoModel> productos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _encabezadoPaginaMovil(productos.length),

        const SizedBox(height: 14),

        Row(
          children: [
            Text(
              '${productos.length} resultados',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: SistemaConstantes.colorTextoSuave,
              ),
            ),
            const Spacer(),
            OutlinedButton.icon(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.tune, size: 18),
              label: const Text('Filtros'),
            ),
          ],
        ),

        const SizedBox(height: 14),

        _opcionesSubcategorias(),

        const SizedBox(height: 18),

        CatalogoGridPaginadoWidget(
          productos: productos,
          opcionesCantidad: opcionesCantidad,
          cantidadInicial: 15,
        ).animate().fadeIn(),
      ],
    );
  }

  /// ===============================
  /// DESKTOP
  /// ===============================
  Widget _layoutDesktop(List<ProductoModel> productos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _encabezadoPaginaDesktop(productos.length),

        const SizedBox(height: 26),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 285, child: _panelFiltrosDesktop()),

            const SizedBox(width: 26),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _opcionesSubcategorias(),

                  const SizedBox(height: 24),

                  CatalogoGridPaginadoWidget(
                    productos: productos,
                    opcionesCantidad: opcionesCantidad,
                    cantidadInicial: 15,
                  ).animate().fadeIn(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ===============================
  /// BANNERS
  /// ===============================
  Widget _encabezadoPaginaMovil(int total) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            SistemaConstantes.colorAzulPrimario,
            SistemaConstantes.colorAzulSecundario,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.categoria.nombre.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$total productos disponibles',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _encabezadoPaginaDesktop(int total) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            SistemaConstantes.colorAzulPrimario,
            SistemaConstantes.colorAzulSecundario,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.categoria.nombre.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$total productos disponibles',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// ===============================
  /// CHIPS
  /// ===============================
  Widget _opcionesSubcategorias() {
    if (widget.categoria.subcategorias.isEmpty) {
      return const SizedBox();
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: widget.categoria.subcategorias.map((item) {
        final activa = subcategoriaSeleccionada == item;

        return InkWell(
          onTap: () {
            setState(() {
              subcategoriaSeleccionada = activa ? null : item;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: activa
                  ? SistemaConstantes.colorAzulPrimario
                  : Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: SistemaConstantes.colorAzulPrimario),
            ),
            child: Text(
              item,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: activa
                    ? Colors.white
                    : SistemaConstantes.colorAzulPrimario,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// ===============================
  /// DRAWER MOBILE
  /// ===============================
  Widget _drawerSectionFiltrosMobile() {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: _panelInternoFiltros(),
        ),
      ),
    );
  }

  Widget _panelFiltrosDesktop() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SistemaConstantes.colorBorde),
        boxShadow: SistemaConstantes.sombraSuave,
      ),
      child: _panelInternoFiltros(),
    );
  }

  Widget _panelInternoFiltros() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filtros',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: SistemaConstantes.colorAzulPrimario,
          ),
        ),
        const SizedBox(height: 18),
        ...widget.categoria.subcategorias.map((item) {
          return RadioListTile<String>(
            dense: true,
            value: item,
            groupValue: subcategoriaSeleccionada,
            title: Text(item),
            onChanged: (value) {
              setState(() {
                subcategoriaSeleccionada = value;
              });
            },
          );
        }),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                subcategoriaSeleccionada = null;
              });
            },
            child: const Text('Limpiar filtros'),
          ),
        ),
      ],
    );
  }

  List<ProductoModel> _obtenerProductosFiltrados() {
    List<ProductoModel> lista = List.from(widget.categoria.productos);

    if (subcategoriaSeleccionada != null) {
      final filtro = subcategoriaSeleccionada!.toLowerCase();

      lista = lista.where((p) {
        return p.nombre.toLowerCase().contains(filtro) ||
            p.categoria.toLowerCase().contains(filtro) ||
            p.marca.toLowerCase().contains(filtro);
      }).toList();
    }

    return lista;
  }
}
