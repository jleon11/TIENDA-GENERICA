import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import 'package:tienda_motos/services/categoria_services.dart';
import 'package:tienda_motos/services/producto_services.dart';
import 'package:tienda_motos/widgets/categoria_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CategoriaService categoriaService = CategoriaService();
  final ProductoService productoService = ProductoService();

  List<CategoriaModel> listaCategorias = [];
  List<CategoriaModel> listaCategoriasHome = [];

  List<ProductoModel> listaProductos = [];

  List<ProductoModel> listaProductosPromoDelMesHome = [];
  List<ProductoModel> listaProductosMasBuscadosHome = [];
  List<ProductoModel> listaProductosMasVendidosHome = [];

  List<ProductoModel> listaProductosPromoDelMes = [];
  List<ProductoModel> listaProductosMasBuscados = [];
  List<ProductoModel> listaProductosMasVendidos = [];

  bool cargandoCategorias = true;
  bool cargandoProductos = true;

  @override
  void initState() {
    super.initState();
    cargarDatosCategorias();
    cargarDatosProductos();
  }

  Future<void> cargarDatosCategorias() async {
    try {
      listaCategorias = await categoriaService.obtenerCategorias();

      listaCategorias.sort(
        (a, b) => (a.orden ?? 9999).compareTo(b.orden ?? 9999),
      );

      listaCategoriasHome = listaCategorias.where((c) {
        final orden = c.orden ?? 9999;
        return orden >= 1 && orden <= 5;
      }).toList();
    } catch (e) {
      debugPrint('error categorías: $e');
    }

    if (mounted) {
      setState(() {
        cargandoCategorias = false;
      });
    }
  }

  Future<void> cargarDatosProductos() async {
    try {
      listaProductos = await productoService.obtenerProductos();

      listaProductosPromoDelMes = listaProductos
          .where((p) => p.mostrarEnlaSeccion == 'PROMO-DEL-MES')
          .toList();

      listaProductosMasBuscados = listaProductos
          .where((p) => p.mostrarEnlaSeccion == 'LOS-MAS-BUSCADOS')
          .toList();

      listaProductosMasVendidos = listaProductos
          .where((p) => p.mostrarEnlaSeccion == 'LOS-MAS-VENDIDOS')
          .toList();

      listaProductosPromoDelMesHome = listaProductosPromoDelMes
          .take(16)
          .toList();

      listaProductosMasBuscadosHome = listaProductosMasBuscados
          .take(12)
          .toList();

      listaProductosMasVendidosHome = listaProductosMasVendidos
          .take(8)
          .toList();
    } catch (e) {
      debugPrint('error productos: $e');
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
            /// CONTENIDO NORMAL CENTRADO
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
                                productos: listaProductos,
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
                        badgeColor: Colors.red,
                      ),

                      const SizedBox(height: SistemaConstantes.espacioSeccion),

                      ProductGridSection<ProductoModel>(
                        titulo: 'LOS MÁS BUSCADOS',
                        items: listaProductosMasBuscadosHome,
                        filas: 2,
                        anchoItem: 260,
                        alturaItem: 430,
                        espaciado: 8,
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            /// BOLETÍN ANCHO COMPLETO
            const BoletinInformativo(),
            const SizedBox(height: 5),

            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
