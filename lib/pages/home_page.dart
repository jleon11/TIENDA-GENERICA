import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/helpers/icono_categoria_helper.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/categoria_navegacion_model.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/sections/boletin_informativo_section.dart';
import 'package:tienda_motos/sections/footer_section.dart';
import 'package:tienda_motos/sections/product_grid_section.dart';
import 'package:tienda_motos/sections/categoria_section.dart';
import 'package:tienda_motos/sections/promo_section.dart';
import 'package:tienda_motos/services/producto_services.dart';
import 'package:tienda_motos/widgets/categoria_item.dart';

class HomePage extends StatefulWidget {
  final List<CategoriaModel> categoriasGlobales;
  const HomePage({super.key, required this.categoriasGlobales});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductoService productoService = ProductoService();

  List<CategoriaModel> listaCategorias = [];
  List<CategoriaModel> listaCategoriasHome = [];
  List<ProductoModel> listaProductos = [];
  List<ProductoModel> listaProductosPromoDelMesHome = [];
  List<ProductoModel> listaProductosMasBuscadosHome = [];
  List<ProductoModel> listaProductosMasVendidosHome = [];
  bool cargandoProductos = true;

  @override
  void initState() {
    super.initState();

    cargarCategoriasGlobales();
    cargarDatosProductos();
  }

  void cargarCategoriasGlobales() {
    listaCategorias = widget.categoriasGlobales;

    listaCategorias.sort(
      (a, b) => (a.orden ?? 9999).compareTo(b.orden ?? 9999),
    );

    listaCategoriasHome = listaCategorias.where((c) {
      final orden = c.orden ?? 9999;

      return orden >= 1 && orden <= 5;
    }).toList();
  }

  Future<void> cargarDatosProductos() async {
    try {
      listaProductos = await productoService.obtenerProductos();

      listaProductosPromoDelMesHome = listaProductos
          .where((p) => p.mostrarEnlaSeccion == 'PROMO-DEL-MES')
          .take(16)
          .toList();

      listaProductosMasBuscadosHome = listaProductos
          .where((p) => p.mostrarEnlaSeccion == 'LOS-MAS-BUSCADOS')
          .take(12)
          .toList();

      listaProductosMasVendidosHome = listaProductos
          .where((p) => p.mostrarEnlaSeccion == 'LOS-MAS-VENDIDOS')
          .take(8)
          .toList();
    } catch (e) {
      debugPrint('Error productos: $e');
    }

    if (mounted) {
      setState(() {
        cargandoProductos = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),

      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: SistemaConstantes.anchoMaximoContenido,
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SistemaConstantes.paddingHorizontal(width),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),

                      CategoriaSection<CategoriaModel>(
                        titulo: 'NUESTRAS CATEGORÍAS',

                        items: listaCategoriasHome,

                        itemBuilder: (c) => CategoriaItem(
                          nombre: c.nombre,

                          icono: IconosCategoriaHelper.obtenerIcono(c.icono),

                          activa: false,

                          onTap: () {
                            context.go(
                              '/categoria/${c.seoUrl}',
                              extra: CategoriaNavegacionModel(
                                categoriaActiva: c,
                                categorias: listaCategorias,
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: SistemaConstantes.espacioSeccion),

                      PromoSection(
                        titulo: 'PROMO DEL MES',
                        items: listaProductosPromoDelMesHome,
                        badgeTexto: 'Promo del mes',
                        badgeColor: SistemaConstantes.colorAzulPrimario,
                      ),

                      const SizedBox(height: SistemaConstantes.espacioSeccion),

                      ProductGridSection<ProductoModel>(
                        titulo: 'LOS MÁS BUSCADOS',
                        items: listaProductosMasBuscadosHome,
                        filas: 2,
                        anchoItem: SistemaConstantes.cardNormalAncho,
                        alturaItem: SistemaConstantes.cardGrandeAlto,
                        espaciado: 8,
                      ),

                      const SizedBox(height: 40),
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
    );
  }
}
