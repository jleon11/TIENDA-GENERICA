import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

class DrawerTienda extends StatelessWidget {
  final int paginaSeleccionada;
  final Function(int) onCambiarPagina;

  const DrawerTienda({
    super.key,
    required this.paginaSeleccionada,
    required this.onCambiarPagina,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                /// CATEGORÍAS
                const Text(
                  'COMPRAR POR CATEGORÍAS',
                  style: TextStyle(
                    color: Color(0xFF1E478D),
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 20),

                _item(context, Icons.home, 'Inicio', pagina: 0),

                _item(context, Icons.extension, 'Accesorios', pagina: 1),

                _item(context, Icons.headphones, 'Audio y Video'),

                _item(context, Icons.build, 'Herramientas'),

                _item(context, Icons.tire_repair, 'Llantas y Baterías'),

                _item(context, Icons.oil_barrel, 'Mantenimiento'),

                const SizedBox(height: 25),
                const Divider(),
                const SizedBox(height: 25),

                /// CONTACTO
                const Text(
                  'CONTÁCTANOS',
                  style: TextStyle(
                    color: Color(0xFF1E478D),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 20),

                _contactFA(
                  FontAwesomeIcons.squareWhatsapp,
                  'WhatsApp: 8402-1743',
                  iconColor: Colors.green,
                ),

                _contactFA(
                  FontAwesomeIcons.squareFacebook,
                  '@accesoriosgonzales',
                  iconColor: Color(0xFF1877F2),
                ),

                _contactFA(
                  FontAwesomeIcons.squareInstagram,
                  '@accesoriosgonzales',
                  iconColor: Color(0xFFE1306C),
                ),

                _contactFA(
                  FontAwesomeIcons.tiktok,
                  '@accesoriosgonzales',
                  iconColor: Colors.black,
                ),

                _contactFA(
                  FontAwesomeIcons.envelope,
                  'justinleon1111@gmail.com',
                  iconColor: const Color(0xFF1E478D),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String texto, {
    int? pagina,
  }) {
    final bool activo = pagina != null && pagina == paginaSeleccionada;

    return InkWell(
      onTap: pagina == null
          ? null
          : () {
              onCambiarPagina(pagina);
              Navigator.pop(context);
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: SistemaConstantes.colorAzulPrimario, size: 22),

            const SizedBox(width: 18),

            Text(
              texto,
              style: TextStyle(
                fontSize: 18,
                color: activo ? Colors.red : Colors.black87,
                fontWeight: activo ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contact(IconData icon, String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E478D), size: 22),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              texto,
              style: const TextStyle(fontSize: 17, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactFA(
    IconData icon,
    String texto, {
    Color iconColor = const Color(0xFF1E478D),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          FaIcon(icon, color: iconColor, size: 22),

          const SizedBox(width: 18),

          Expanded(
            child: Text(
              texto,
              style: const TextStyle(fontSize: 17, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
