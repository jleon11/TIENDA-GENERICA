import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/helpers/icono_categoria_helper.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/categoria_navegacion_model.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerTienda extends StatelessWidget {
  final List<CategoriaModel> categorias;

  const DrawerTienda({super.key, required this.categorias});

  @override
  Widget build(BuildContext context) {
    final categoriasOrdenadas = [...categorias]
      ..sort((a, b) => (a.orden ?? 9999).compareTo(b.orden ?? 9999));

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

                _itemInicio(context),

                /// DINÁMICO
                ...categoriasOrdenadas.map((c) => _itemCategoria(context, c)),

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
                  'WhatsApp: 6298-4141',
                  iconColor: Colors.green,
                  url: Uri(
                    scheme: 'https',
                    host: 'wa.me',
                    path: '/50662984141',
                    queryParameters: {
                      'text':
                          'Hola, me interesa obtener más información sobre sus productos y accesorios.',
                    },
                  ).toString(),
                ),

                _contactFA(
                  FontAwesomeIcons.squareFacebook,
                  '@accesoriosgonzales',
                  iconColor: const Color(0xFF1877F2),
                  url:
                      'https://www.facebook.com/p/Accesorios-Gonz%C3%A1lez-61572541004954/',
                ),

                _contactFA(
                  FontAwesomeIcons.squareInstagram,
                  '@accesoriosgonzales',
                  iconColor: const Color(0xFFE1306C),
                  url:
                      'https://www.threads.com/@justinleon3695?xmt=AQF0G0gerjjgV-vjjpvoweWC2awIvB-u6HnvrMJMiKrprwk',
                ),

                _contactFA(
                  FontAwesomeIcons.tiktok,
                  '@accesoriosgonzales',
                  iconColor: Colors.black,
                  url: 'https://www.tiktok.com/@tgcostarica',
                ),

                _contactFA(
                  FontAwesomeIcons.envelope,
                  'justinleon1111@gmail.com',
                  iconColor: const Color(0xFF1E478D),
                  url: 'mailto:justinleon1111@gmail.com',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: const Color(0xFFF7F7F7),
                  child: const Text(
                    '©️ Tienda Motos',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
  */

  Widget _itemInicio(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        context.go('/');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.grid_view_rounded,
              color: SistemaConstantes.colorAzulPrimario,
              size: 22,
            ),

            const SizedBox(width: 18),

            const Text(
              'Inicio',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemCategoria(BuildContext context, CategoriaModel c) {
    final ruta = c.seoUrl.trim();

    return InkWell(
      onTap: ruta.isEmpty
          ? null
          : () {
              Navigator.pop(context);

              context.go(
                '/categoria/$ruta',
                extra: CategoriaNavegacionModel(
                  categoriaActiva: c,
                  categorias: categorias,
                ),
              );
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              IconosCategoriaHelper.obtenerIcono(c.icono),
              color: SistemaConstantes.colorAzulPrimario,
              size: 22,
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Text(
                c.nombre,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactFA(
    IconData icon,
    String texto, {
    Color iconColor = const Color(0xFF1E478D),
    String? url,
  }) {
    return InkWell(
      onTap: url == null
          ? null
          : () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
      child: Padding(
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
      ),
    );
  }
}
