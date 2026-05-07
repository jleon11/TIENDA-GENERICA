import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/helpers/icono_categoria_helper.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/categoria_navegacion_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerTienda extends StatelessWidget {
  final List<CategoriaModel> categorias;

  const DrawerTienda({super.key, required this.categorias});

  static const _azul = Color(0xFF1E478D);
  static const _azulClaro = Color(0xFFEEF3FB);
  static const _gris = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    final categoriasOrdenadas = [...categorias]
      ..sort((a, b) => (a.orden ?? 9999).compareTo(b.orden ?? 9999));

    return Drawer(
      width: 300,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            /// HEADER
            _header(),

            /// CONTENIDO SCROLLEABLE
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _seccionLabel('NAVEGACIÓN'),
                    _itemInicio(context),

                    const SizedBox(height: 4),
                    _seccionLabel('CATEGORÍAS'),
                    ...categoriasOrdenadas.map(
                      (c) => _itemCategoria(context, c),
                    ),

                    const SizedBox(height: 8),
                    _divider(),

                    _seccionLabel('CONTÁCTANOS'),
                    _contactFA(
                      FontAwesomeIcons.squareWhatsapp,
                      'WhatsApp: 6298-4141',
                      iconColor: const Color(0xFF25D366),
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
                      iconColor: Colors.black87,
                      url: 'https://www.tiktok.com/@tgcostarica',
                    ),
                    _contactFA(
                      FontAwesomeIcons.envelope,
                      'justinleon1111@gmail.com',
                      iconColor: _azul,
                      url: 'mailto:justinleon1111@gmail.com',
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            /// FOOTER
            _footer(),
          ],
        ),
      ),
    );
  }

  /// ──────────────────────────────────────────
  /// HEADER con gradiente
  /// ──────────────────────────────────────────
  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A5CB8), Color(0xFF0D1F5C)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.storefront_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Accesorios\nGonzález',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tu tienda de confianza',
            style: TextStyle(
              color: Colors.white.withOpacity(0.65),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  /// ──────────────────────────────────────────
  /// LABEL de sección
  /// ──────────────────────────────────────────
  Widget _seccionLabel(String texto) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 6),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: _gris,
          letterSpacing: 1.4,
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Divider(color: Colors.grey.shade200, height: 1),
    );
  }

  /// ──────────────────────────────────────────
  /// ITEM INICIO
  /// ──────────────────────────────────────────
  Widget _itemInicio(BuildContext context) {
    return _drawerItem(
      context: context,
      icono: Icons.home_outlined,
      label: 'Inicio',
      onTap: () {
        Navigator.pop(context);
        context.go('/');
      },
    );
  }

  /// ──────────────────────────────────────────
  /// ITEM CATEGORÍA
  /// ──────────────────────────────────────────
  Widget _itemCategoria(BuildContext context, CategoriaModel c) {
    final ruta = c.seoUrl.trim();

    return _drawerItem(
      context: context,
      icono: IconosCategoriaHelper.obtenerIcono(c.icono),
      label: c.nombre,
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
    );
  }

  /// ──────────────────────────────────────────
  /// ITEM GENÉRICO (ícono Material)
  /// ──────────────────────────────────────────
  Widget _drawerItem({
    required BuildContext context,
    required IconData icono,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: _azulClaro,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icono, color: _azul, size: 18),
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, size: 16, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }

  /// ──────────────────────────────────────────
  /// CONTACTO (Font Awesome)
  /// ──────────────────────────────────────────
  Widget _contactFA(
    IconData icon,
    String texto, {
    Color iconColor = _azul,
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
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: Row(
            children: [
              FaIcon(icon, color: iconColor, size: 20),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ──────────────────────────────────────────
  /// FOOTER
  /// ──────────────────────────────────────────
  Widget _footer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: const Text(
        '© 2025 Accesorios González',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: _gris,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
