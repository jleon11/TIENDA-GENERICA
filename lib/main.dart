import 'package:flutter/material.dart';
import 'package:tienda_motos/pages/header.dart';
import 'package:tienda_motos/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E478D), // 🔥 tu azul
        ),

        scaffoldBackgroundColor: Colors.white,
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

  /// 🔥 PÁGINAS
  final List<Widget> paginas = const [
    HomePage(),
    //ProductosPage(),
    //ContactoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Builder(builder: (context) => const HeaderTienda()),
      ),

      /// 🔥 DRAWER
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1E478D)),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menú',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),

            _item(0, Icons.home, 'Inicio'),
            _item(1, Icons.store, 'Productos'),
            _item(2, Icons.contact_page, 'Contacto'),
          ],
        ),
      ),

      /// 🔥 CONTENIDO
      body: paginas[paginaSeleccionada],
    );
  }

  /// 🔥 ITEM DEL MENÚ
  Widget _item(int index, IconData icono, String texto) {
    return ListTile(
      leading: Icon(icono),
      title: Text(texto),
      selected: paginaSeleccionada == index,
      onTap: () {
        setState(() {
          paginaSeleccionada = index;
        });

        Navigator.pop(context); // 🔥 cerrar drawer
      },
    );
  }
}
