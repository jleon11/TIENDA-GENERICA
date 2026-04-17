import 'package:go_router/go_router.dart';
import 'package:tienda_motos/main.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/pages/home_page.dart';
import 'package:tienda_motos/pages/producto_detalle_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
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
  ],
);
