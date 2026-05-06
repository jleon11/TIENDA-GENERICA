import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/models/producto_model.dart';

import 'package:tienda_motos/providers/busqueda_productos_provider.dart';
import 'package:tienda_motos/providers/carrito_provider.dart';

import 'package:tienda_motos/services/producto_services.dart';

class HeaderTienda extends StatefulWidget {
  const HeaderTienda({super.key});

  @override
  State<HeaderTienda> createState() => _HeaderTiendaState();
}

class _HeaderTiendaState extends State<HeaderTienda> {
  final ProductoService productoService = ProductoService();

  final FocusNode buscadorFocus = FocusNode();

  List<ProductoModel> listaProductos = [];

  /// ==========================================
  /// CARGAR PRODUCTOS
  /// ==========================================
  Future<void> cargarProductos() async {
    try {
      listaProductos = await productoService.obtenerProductos();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error cargando productos: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    cargarProductos();

    /// ==========================================
    /// CERRAR RESULTADOS SI PIERDE FOCUS
    /// ==========================================
    buscadorFocus.addListener(() {
      if (!buscadorFocus.hasFocus) {
        if (mounted) {
          context.read<BusquedaProductosProvider>().limpiar();
        }
      }
    });
  }

  @override
  void dispose() {
    buscadorFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final esMovil = width < 900;

    final esTablet = width >= 900 && width < 1300;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,

      onTap: () {
        FocusScope.of(context).unfocus();
      },

      child: Material(
        elevation: 2,
        color: Colors.white,

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: SistemaConstantes.anchoMaximoHeader,
            ),

            child: Container(
              height: SistemaConstantes.altoHeader,

              padding: EdgeInsets.symmetric(horizontal: esMovil ? 12 : 24),

              child: Row(
                children: [
                  /// =====================================
                  /// MENU
                  /// =====================================
                  IconButton(
                    icon: const Icon(Icons.menu, size: 28),

                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),

                  const SizedBox(width: 10),

                  /// =====================================
                  /// LOGO
                  /// =====================================
                  InkWell(
                    onTap: () {},

                    child: Image.asset(
                      'assets/imagenes/logo-accesoriosGonzales-fondoBlanco.png',

                      height: esMovil ? 52 : 68,

                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(width: 18),

                  /// =====================================
                  /// BUSCADOR
                  /// =====================================
                  Expanded(
                    child: Consumer<BusquedaProductosProvider>(
                      builder: (context, busqueda, _) {
                        return Stack(
                          clipBehavior: Clip.none,

                          children: [
                            /// =========================
                            /// INPUT
                            /// =========================
                            Container(
                              height: 46,

                              decoration: BoxDecoration(
                                color: Colors.white,

                                border: Border.all(
                                  color: SistemaConstantes.colorAzulPrimario,
                                ),

                                borderRadius: BorderRadius.circular(28),
                              ),

                              child: Row(
                                children: [
                                  const SizedBox(width: 14),

                                  const Icon(
                                    Icons.search,

                                    size: 20,

                                    color: Colors.grey,
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: TextField(
                                      focusNode: buscadorFocus,

                                      onChanged: (value) {
                                        context
                                            .read<BusquedaProductosProvider>()
                                            .buscarProductos(
                                              texto: value,

                                              productos: listaProductos,
                                            );
                                      },

                                      decoration: const InputDecoration(
                                        hintText: 'Buscar productos...',

                                        border: InputBorder.none,

                                        isDense: true,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    height: 46,

                                    width: esMovil ? 44 : 54,

                                    decoration: const BoxDecoration(
                                      color:
                                          SistemaConstantes.colorAzulPrimario,

                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(28),

                                        bottomRight: Radius.circular(28),
                                      ),
                                    ),

                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.arrow_forward,

                                        color: Colors.white,

                                        size: 20,
                                      ),

                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// =========================
                            /// RESULTADOS
                            /// =========================
                            if (busqueda.mostrarResultados)
                              Positioned(
                                top: 56,

                                left: 0,
                                right: 0,

                                child: Material(
                                  color: Colors.transparent,

                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxHeight: 420,
                                    ),

                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(18),

                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),

                                          blurRadius: 18,

                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),

                                    child: busqueda.resultados.isEmpty
                                        ? SizedBox(
                                            height: 90,

                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,

                                              children: [
                                                Icon(
                                                  Icons.search_off_rounded,

                                                  size: 22,

                                                  color: Colors.grey.shade400,
                                                ),

                                                const SizedBox(width: 10),

                                                Text(
                                                  'No encontramos coincidencias para "${busqueda.textoBusqueda}"',

                                                  style: TextStyle(
                                                    fontSize: 14,

                                                    fontWeight: FontWeight.w500,

                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.separated(
                                            shrinkWrap: true,

                                            physics:
                                                const BouncingScrollPhysics(),

                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),

                                            itemCount:
                                                busqueda.resultados.length,

                                            separatorBuilder: (_, __) =>
                                                Divider(
                                                  height: 1,

                                                  color: Colors.grey.shade200,
                                                ),

                                            itemBuilder: (_, index) {
                                              final p =
                                                  busqueda.resultados[index];

                                              return ListTile(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 14,

                                                      vertical: 8,
                                                    ),

                                                leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),

                                                  child: Image.network(
                                                    p.imagenPrincipal,

                                                    width: 62,

                                                    height: 62,

                                                    fit: BoxFit.contain,

                                                    errorBuilder:
                                                        (_, __, ___) => Icon(
                                                          Icons
                                                              .image_not_supported_outlined,

                                                          color: Colors
                                                              .grey
                                                              .shade400,
                                                        ),
                                                  ),
                                                ),

                                                title: Text(
                                                  p.nombre,

                                                  maxLines: 1,

                                                  overflow:
                                                      TextOverflow.ellipsis,

                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,

                                                    fontSize: 15,

                                                    color: SistemaConstantes
                                                        .colorAzulPrimario,
                                                  ),
                                                ),

                                                onTap: () {
                                                  FocusScope.of(
                                                    context,
                                                  ).unfocus();

                                                  busqueda.limpiar();

                                                  // navegar producto
                                                },
                                              );
                                            },
                                          ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// =====================================
                  /// FAVORITOS
                  /// =====================================
                  if (!esMovil)
                    _iconoHeader(
                      icono: Icons.favorite_border,

                      color: Colors.red,
                    ),

                  if (!esMovil) const SizedBox(width: 12),

                  /// =====================================
                  /// CARRITO
                  /// =====================================
                  Builder(
                    builder: (context) => Consumer<CarritoProvider>(
                      builder: (context, carrito, _) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openEndDrawer();
                          },

                          child: Stack(
                            clipBehavior: Clip.none,

                            children: [
                              Container(
                                width: 42,
                                height: 42,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),

                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),

                                child: const Icon(
                                  Icons.shopping_cart_outlined,

                                  color: Colors.red,

                                  size: 22,
                                ),
                              ),

                              if (carrito.totalItems > 0)
                                Positioned(
                                  right: -2,

                                  top: -2,

                                  child: Container(
                                    width: 18,

                                    height: 18,

                                    decoration: const BoxDecoration(
                                      color: Colors.red,

                                      shape: BoxShape.circle,
                                    ),

                                    alignment: Alignment.center,

                                    child: Text(
                                      '${carrito.totalItems}',

                                      style: const TextStyle(
                                        color: Colors.white,

                                        fontSize: 10,

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  if (esTablet) const SizedBox(width: 6),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconoHeader({
    required IconData icono,
    required Color color,

    bool badge = false,
  }) {
    return Stack(
      clipBehavior: Clip.none,

      children: [
        Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),

            border: Border.all(color: Colors.grey.shade300),
          ),

          child: Icon(icono, color: color, size: 22),
        ),

        if (badge)
          Positioned(
            right: -2,
            top: -2,

            child: Container(
              width: 18,
              height: 18,

              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),

              alignment: Alignment.center,

              child: const Text(
                '0',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
