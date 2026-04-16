import 'package:go_router/go_router.dart';
import 'package:tienda_motos/pages/producto_detalle_page.dart';
import '../pages/home_page.dart';
import '../models/producto_model.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),

    GoRoute(
      path: '/DetalleProducto',
      builder: (context, state) {
        final producto = state.extra as ProductoModel;
        return ProductoDetallePage(producto: producto);
      },
    ),
  ],
);
