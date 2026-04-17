import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/pages/header.dart';
import 'package:tienda_motos/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Tienda Motos',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: SistemaConstantes.colorPrimario,
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
              color: SistemaConstantes.colorPrimario,
              width: 1.5,
            ),
          ),
        ),
      ),

      home: const LayoutPrincipal(),
    );
  }
}

class LayoutPrincipal extends StatefulWidget {
  const LayoutPrincipal({super.key});

  @override
  State<LayoutPrincipal> createState() => _LayoutPrincipalState();
}

class _LayoutPrincipalState extends State<LayoutPrincipal> {
  int paginaSeleccionada = 0;

  final List<Widget> paginas = const [HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Builder(builder: (context) => const HeaderTienda()),
      ),

      body: paginas[paginaSeleccionada],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: SistemaConstantes.colorPrimario,
              child: const Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _item(0, Icons.home, 'Inicio'),

            _item(1, Icons.store, 'Productos'),

            _item(2, Icons.contact_page, 'Contacto'),
          ],
        ),
      ),
    );
  }

  Widget _item(int index, IconData icono, String texto) {
    final activo = paginaSeleccionada == index;

    return ListTile(
      leading: Icon(
        icono,
        color: activo ? SistemaConstantes.colorPrimario : Colors.black87,
      ),

      title: Text(
        texto,
        style: TextStyle(
          fontWeight: activo ? FontWeight.bold : FontWeight.normal,
          color: activo ? SistemaConstantes.colorPrimario : Colors.black87,
        ),
      ),

      selected: activo,

      onTap: () {
        setState(() {
          paginaSeleccionada = index;
        });

        Navigator.pop(context);
      },
    );
  }
}
