import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/sections/header_section.dart';
import 'package:tienda_motos/routes/app_router.dart';
import 'package:tienda_motos/widgets/drawer_tienda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Tienda Motos',

      routerConfig: appRouter,

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: SistemaConstantes.colorAzulPrimario,
        ),

        fontFamily: 'Arial',

        dividerColor: Colors.grey.shade200,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          surfaceTintColor: Colors.white,
        ),

        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: SistemaConstantes.colorAzulPrimario,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class LayoutPrincipal extends StatefulWidget {
  final Widget child;

  const LayoutPrincipal({super.key, required this.child});

  @override
  State<LayoutPrincipal> createState() => _LayoutPrincipalState();
}

class _LayoutPrincipalState extends State<LayoutPrincipal> {
  int paginaSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerTienda(
        paginaSeleccionada: paginaSeleccionada,
        onCambiarPagina: (index) {
          setState(() {
            paginaSeleccionada = index;
          });
        },
      ),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Builder(builder: (context) => const HeaderTienda()),
      ),

      body: widget.child,
    );
  }
}
