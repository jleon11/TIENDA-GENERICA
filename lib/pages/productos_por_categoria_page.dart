import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/helpers/icono_categoria_helper.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/categoria_navegacion_model.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/models/subcategoria_model.dart';
import 'package:tienda_motos/sections/boletin_informativo_section.dart';
import 'package:tienda_motos/sections/footer_section.dart';
import 'package:tienda_motos/services/producto_services.dart';
import 'package:tienda_motos/widgets/general_components/catalogoGenerico_grid_paginado_.dart';

class ProductosPorCategoriaPage extends StatefulWidget {
  final CategoriaModel categoriaActiva;
  final List<CategoriaModel> categorias;

  const ProductosPorCategoriaPage({
    super.key,
    required this.categoriaActiva,
    required this.categorias,
  });

  @override
  State<ProductosPorCategoriaPage> createState() =>
      _ProductosPorCategoriaPageState();
}

class _ProductosPorCategoriaPageState extends State<ProductosPorCategoriaPage> {
  final List<int> opcionesCantidad = const [15, 25, 50];
  List<ProductoModel> listaProductosPorCategoria = [];
  List<SubCategoriaModel> subCategorias = [];

  // ✅ NUEVO: subcategoría seleccionada (null = "Todas")
  SubCategoriaModel? subCategoriaSeleccionada;

  bool cargandoProductos = true;

  @override
  void initState() {
    super.initState();
    cargarProductosPorCategoria();
  }

  Future<void> cargarProductosPorCategoria() async {
    try {
      listaProductosPorCategoria = await ProductoService()
          .productosPorCategoria(widget.categoriaActiva.seoUrl);

      final mapa = <String, SubCategoriaModel>{};
      for (final p in listaProductosPorCategoria) {
        if (p.subcategoria != null) {
          mapa[p.subcategoria!.id] = p.subcategoria!;
        }
      }
      subCategorias = mapa.values.toList();
    } catch (e) {
      debugPrint('Error cargando productos: $e');
    }

    if (mounted) setState(() => cargandoProductos = false);
  }

  // ✅ NUEVO: productos filtrados según subcategoría activa
  List<ProductoModel> get productosFiltrados {
    if (subCategoriaSeleccionada == null) return listaProductosPorCategoria;
    return listaProductosPorCategoria
        .where((p) => p.subcategoria?.id == subCategoriaSeleccionada!.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final esMovil = width < 980;

    return Scaffold(
      backgroundColor: SistemaConstantes.colorFondo,
      endDrawer: esMovil ? _drawerCategorias() : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SistemaConstantes.paddingHorizontal(width),
                  vertical: esMovil ? 14 : 24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: SistemaConstantes.anchoMaximoContenido,
                    ),
                    child: esMovil
                        ? _layoutMovil(productosFiltrados)
                        : _layoutDesktop(productosFiltrados),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const BoletinInformativo(),
              const SizedBox(height: 8),
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // ✅ NUEVO: Sección de subcategorías con iconos circulares
  // =====================================================

  Widget _seccionSubcategorias({required bool esMovil}) {
    if (subCategorias.isEmpty) return const SizedBox.shrink();

    final double iconSize = esMovil ? 52 : 64;
    final double fontSize = esMovil ? 11 : 12;

    final items = <Widget>[
      /*
      _chipSubcategoria(
        icono: Icons.grid_view_rounded,
        nombre: 'Todas',
        activa: subCategoriaSeleccionada == null,
        iconSize: iconSize,
        fontSize: fontSize,
        onTap: () => setState(() => subCategoriaSeleccionada = null),
      ),

*/
      ...subCategorias.map(
        (sub) => _chipSubcategoria(
          icono: IconosCategoriaHelper.obtenerIcono(
            sub.icono,
          ), // ✅ usa tu helper
          nombre: sub.nombre,
          activa: subCategoriaSeleccionada?.id == sub.id,
          iconSize: iconSize,
          fontSize: fontSize,
          onTap: () => setState(() => subCategoriaSeleccionada = sub),
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Subcategorías',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: SistemaConstantes.colorTextoSuave,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items
                .map(
                  (w) => Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: w,
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 8),
        Divider(color: Colors.grey.shade200, height: 1),
      ],
    );
  }

  Widget _chipSubcategoria({
    required IconData icono,
    required String nombre,
    required bool activa,
    required double iconSize,
    required double fontSize,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activa
                    ? SistemaConstantes.colorAzulPrimario
                    : Colors.white,
                border: Border.all(
                  color: activa
                      ? SistemaConstantes.colorAzulPrimario
                      : Colors.grey.shade300,
                  width: activa ? 2 : 1.5,
                ),
                boxShadow: activa
                    ? [
                        BoxShadow(
                          color: SistemaConstantes.colorAzulPrimario
                              .withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Icon(
                icono,
                size: iconSize * 0.45,
                color: activa
                    ? Colors.white
                    : SistemaConstantes.colorAzulPrimario,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              nombre,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: activa ? FontWeight.w700 : FontWeight.w500,
                color: activa
                    ? SistemaConstantes.colorAzulPrimario
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // MOBILE
  // =====================================================
  Widget _layoutMovil(List<ProductoModel> productos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mijagaDePan(),
        const SizedBox(height: 10),
        _bannerCategoria(
          total: listaProductosPorCategoria.length,
          esMovil: true,
        ),
        const SizedBox(height: 14),

        // Chips de categorías horizontales (como ya tenías)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.categorias.map((c) {
              final activa = c.seoUrl == widget.categoriaActiva.seoUrl;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () => _irCategoria(c),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: activa
                          ? SistemaConstantes.colorAzulPrimario
                          : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: SistemaConstantes.colorAzulPrimario,
                      ),
                    ),
                    child: Text(
                      c.nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: activa
                            ? Colors.white
                            : SistemaConstantes.colorAzulPrimario,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 20),

        // ✅ NUEVO: subcategorías con íconos
        _seccionSubcategorias(esMovil: true),

        const SizedBox(height: 18),

        CatalogoGridWidget(
          productos: productos,
          opcionesCantidad: opcionesCantidad,
          cantidadInicial: 15,
        ).animate().fadeIn(),
      ],
    );
  }

  // =====================================================
  // DESKTOP
  // =====================================================
  Widget _layoutDesktop(List<ProductoModel> productos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mijagaDePan(),
        const SizedBox(height: 12),
        _bannerCategoria(
          total: listaProductosPorCategoria.length,
          esMovil: false,
        ),
        const SizedBox(height: 28),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Panel izquierdo: categorías (sin cambios)
            SizedBox(width: 260, child: _drawerCategoriasDesktop()),

            const SizedBox(width: 28),

            // ✅ Lado derecho: subcategorías ARRIBA del grid
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _seccionSubcategorias(
                    esMovil: false,
                  ), // ✅ aquí, alineado con el grid
                  const SizedBox(height: 20),
                  CatalogoGridWidget(
                    productos: productosFiltrados,
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

  // =====================================================
  // BREADCRUMB (sin cambios)
  // =====================================================
  Widget mijagaDePan() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        InkWell(
          onTap: () => context.go('/'),
          child: const Text(
            'Inicio',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: SistemaConstantes.colorTextoSuave,
            ),
          ),
        ),
        const Icon(
          Icons.chevron_right,
          size: 16,
          color: SistemaConstantes.colorTextoSuave,
        ),
        Text(
          widget.categoriaActiva.nombre,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: SistemaConstantes.colorTexto,
          ),
        ),
      ],
    );
  }

  // =====================================================
  // BANNER (sin cambios, solo se usa listaProductosPorCategoria.length para el total real)
  // =====================================================
  Widget _bannerCategoria({required int total, required bool esMovil}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(esMovil ? 18 : 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(esMovil ? 22 : 28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 48, 119, 212),
            Color(0xFF1A3A8F),
            Color(0xFF0D1F5C),
          ],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'CATEGORÍA',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.categoriaActiva.nombre.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: esMovil ? 22 : 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Encuentra lo que necesitas',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: esMovil ? 13 : 15,
                      ),
                    ),
                  ],
                ),
              ),
              if (!esMovil) ...[
                _bannerEstadistico('$total', 'Productos'),
                _dividerVertical(),
                _bannerEstadistico('${subCategorias.length}', 'Subcategorías'),
              ],
            ],
          ),
          if (esMovil) ...[
            const SizedBox(height: 8),
            Text(
              '$total productos disponibles',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }

  Widget _bannerEstadistico(String valor, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          valor,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 9,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _dividerVertical() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 0.5,
      height: 32,
      color: Colors.white24,
    );
  }

  // =====================================================
  // PANEL DESKTOP (sin cambios)
  // =====================================================
  Widget _drawerCategoriasDesktop() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filtros',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
              letterSpacing: .2,
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
          const SizedBox(height: 6),
          ...widget.categorias.map((c) {
            final activa = c.seoUrl == widget.categoriaActiva.seoUrl;
            return InkWell(
              onTap: () => _irCategoria(c),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activa
                            ? SistemaConstantes.colorAzulPrimario
                            : Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        c.nombre,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: activa
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: activa
                              ? SistemaConstantes.colorAzulPrimario
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // =====================================================
  // DRAWER MOBILE (sin cambios)
  // =====================================================
  Widget _drawerCategorias() {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filtros',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.categorias.map((c) {
                      return RadioListTile<String>(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: c.seoUrl,
                        groupValue: widget.categoriaActiva.seoUrl,
                        title: Text(c.nombre),
                        activeColor: SistemaConstantes.colorAzulPrimario,
                        onChanged: (_) {
                          Navigator.pop(context);
                          _irCategoria(c);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // NAV
  // =====================================================
  void _irCategoria(CategoriaModel c) {
    if (c.seoUrl == widget.categoriaActiva.seoUrl) return;
    context.go(
      '/categoria/${c.seoUrl}',
      extra: CategoriaNavegacionModel(
        categoriaActiva: c,
        categorias: widget.categorias,
      ),
    );
  }
}
