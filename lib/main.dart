import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:forui/forui.dart';
import 'package:provider/provider.dart';

import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/providers/busqueda_productos_provider.dart';

import 'package:tienda_motos/providers/carrito_provider.dart';

import 'package:tienda_motos/routes/app_router.dart';

import 'package:tienda_motos/sections/carrito_drawer.dart';
import 'package:tienda_motos/sections/header_section.dart';

import 'package:tienda_motos/services/categoria_services.dart';

import 'package:tienda_motos/widgets/drawer_tienda.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        /// ==========================================
        /// CARRITO
        /// ==========================================
        ChangeNotifierProvider(create: (_) => CarritoProvider()),

        /// ==========================================
        /// BUSQUEDA GLOBAL
        /// ==========================================
        ChangeNotifierProvider(create: (_) => BusquedaProductosProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// ==========================================
    /// FORUI THEME
    /// ==========================================
    final theme =
        const <TargetPlatform>{
          TargetPlatform.android,
          TargetPlatform.iOS,
          TargetPlatform.fuchsia,
        }.contains(defaultTargetPlatform)
        ? FThemes.neutral.light.touch
        : FThemes.neutral.light.desktop;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'Accesorios Gonzales',

      routerConfig: appRouter,

      /// MATERIAL ← FORUI bridge
      theme: theme.toApproximateMaterialTheme(),

      builder: (_, child) {
        return FTheme(
          data: theme,

          child: FToaster(child: FTooltipGroup(child: child!)),
        );
      },
    );
  }
}

class LayoutPrincipal extends StatefulWidget {
  final Widget Function(List<CategoriaModel>) childBuilder;

  const LayoutPrincipal({super.key, required this.childBuilder});

  @override
  State<LayoutPrincipal> createState() => _LayoutPrincipalState();
}

class _LayoutPrincipalState extends State<LayoutPrincipal> {
  List<CategoriaModel> categorias = [];

  bool cargandoCategorias = true;

  @override
  void initState() {
    super.initState();

    cargarCategorias();
  }

  /// ==========================================
  /// CARGAR CATEGORIAS
  /// ==========================================
  Future<void> cargarCategorias() async {
    try {
      categorias = await CategoriaService().obtenerCategorias();
    } catch (e) {
      debugPrint('Error categorías: $e');
    }

    if (mounted) {
      setState(() {
        cargandoCategorias = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      /// ==========================================
      /// DRAWER IZQUIERDO
      /// ==========================================
      drawer: DrawerTienda(categorias: categorias),

      /// ==========================================
      /// CARRITO
      /// ==========================================
      endDrawer: const CarritoDrawer(),

      /// ==========================================
      /// HEADER
      /// ==========================================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),

        child: Builder(builder: (context) => const HeaderTienda()),
      ),

      /// ==========================================
      /// BODY
      /// ==========================================
      body: cargandoCategorias
          ? const Center(child: CircularProgressIndicator())
          : widget.childBuilder(categorias),
    );
  }
}
