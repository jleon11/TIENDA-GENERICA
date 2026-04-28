import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_motos/main.dart';
import 'package:tienda_motos/models/categoria_navegacion_model.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/pages/home_page.dart';
import 'package:tienda_motos/pages/producto_detalle_page.dart';
import 'package:tienda_motos/pages/productos_por_categoria_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  errorBuilder: (context, state) {
    debugPrint('Ruta no encontrada: ${state.uri}');
    debugPrint('Error detectado: ${state.error}');
    return const LayoutPrincipal(child: HomePage());
  },

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const LayoutPrincipal(child: HomePage());
      },
    ),

    GoRoute(
      path: '/producto',
      builder: (context, state) {
        final producto = state.extra as ProductoModel;

        return LayoutPrincipal(child: ProductoDetallePage(producto: producto));
      },
    ),

    GoRoute(
      path: '/categoria/:ruta',
      pageBuilder: (context, state) {
        final data = state.extra as CategoriaNavegacionModel;

        return MaterialPage(
          key: ValueKey(state.uri.toString()),
          child: LayoutPrincipal(
            child: ProductosPorCategoriaPage(
              categoriaActiva: data.categoriaActiva,
              categorias: data.categorias,
              productos: data.productos,
            ),
          ),
        );
      },
    ),
  ],
);
