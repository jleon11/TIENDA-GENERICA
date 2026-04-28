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
    return LayoutPrincipal(
      childBuilder: (categorias) => HomePage(categoriasGlobales: categorias),
    );
  },

  routes: [
    GoRoute(
      path: '/',

      builder: (context, state) {
        return LayoutPrincipal(
          childBuilder: (categorias) =>
              HomePage(categoriasGlobales: categorias),
        );
      },
    ),

    GoRoute(
      path: '/producto',

      builder: (context, state) {
        final producto = state.extra as ProductoModel;

        return LayoutPrincipal(
          childBuilder: (categorias) => ProductoDetallePage(
            producto: producto,
            categoriasGlobales: categorias,
          ),
        );
      },
    ),

    GoRoute(
      path: '/categoria/:ruta',

      pageBuilder: (context, state) {
        final data = state.extra as CategoriaNavegacionModel;

        return MaterialPage(
          key: ValueKey(state.uri.toString()),

          child: LayoutPrincipal(
            childBuilder: (categorias) => ProductosPorCategoriaPage(
              categoriaActiva: data.categoriaActiva,
              categorias: categorias,
            ),
          ),
        );
      },
    ),
  ],
);
