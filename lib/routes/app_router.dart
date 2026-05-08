import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_motos/main.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/pages/home_page.dart';
import 'package:tienda_motos/pages/producto_detalle_page.dart';
import 'package:tienda_motos/pages/productos_por_categoria_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  errorBuilder: (context, state) {
    return LayoutPrincipal(
      childBuilder: (categorias, subcategorias) => HomePage(
        categoriasGlobales: categorias,
        subcategoriasGlobales: subcategorias,
      ),
    );
  },

  routes: [
    GoRoute(
      path: '/',

      builder: (context, state) {
        return LayoutPrincipal(
          childBuilder: (categorias, subcategorias) => HomePage(
            categoriasGlobales: categorias,
            subcategoriasGlobales: subcategorias,
          ),
        );
      },
    ),

    GoRoute(
      path: '/producto',

      builder: (context, state) {
        final producto = state.extra as ProductoModel;

        return LayoutPrincipal(
          childBuilder: (categorias, subcategorias) => ProductoDetallePage(
            producto: producto,
            categoriasGlobales: categorias,
          ),
        );
      },
    ),

    /// CATEGORÍA PADRE → /categoria/tecnologia
    GoRoute(
      path: '/categoria/:cat',
      pageBuilder: (context, state) {
        final catSeo = state.pathParameters['cat']!;

        return MaterialPage(
          key: ValueKey(state.uri.toString()),
          child: LayoutPrincipal(
            childBuilder: (categorias, subcategorias) =>
                ProductosPorCategoriaPage(
                  categoriaActiva: categorias.firstWhere(
                    (c) => c.seoUrl == catSeo,
                    orElse: () => categorias.first,
                  ),
                  categorias: categorias,
                  subCategoriasGlobales: subcategorias,

                  subcategoriaPreFiltrado: null,
                ),
          ),
        );
      },
    ),

    /// SUBCATEGORÍA → /categoria/tecnologia/celulares
    GoRoute(
      path: '/categoria/:cat/:subcat',
      pageBuilder: (context, state) {
        final catSeo = state.pathParameters['cat']!;
        final subcatSeo = state.pathParameters['subcat']!;

        return MaterialPage(
          key: ValueKey(state.uri.toString()),
          child: LayoutPrincipal(
            childBuilder: (categorias, subcategorias) =>
                ProductosPorCategoriaPage(
                  categoriaActiva: categorias.firstWhere(
                    (c) => c.seoUrl == catSeo,
                    orElse: () => categorias.first,
                  ),

                  categorias: categorias,

                  subCategoriasGlobales: subcategorias,

                  subcategoriaPreFiltrado: null,
                ),
          ),
        );
      },
    ),
  ],
);
