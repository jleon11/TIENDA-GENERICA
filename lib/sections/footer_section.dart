import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool esMovil = width < 900;

    return Container(
      width: double.infinity,
      color: SistemaConstantes.colorAzulSecundario,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: SistemaConstantes.anchoBoletin(width),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SistemaConstantes.paddingHorizontal(width),
              vertical: 50,
            ),
            child: Column(
              children: [
                /// BLOQUE SUPERIOR
                esMovil
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _marca(),
                          const SizedBox(height: 35),
                          _contacto(),
                          const SizedBox(height: 35),
                          _informacion(),
                          const SizedBox(height: 35),
                          _ubicacion(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 3, child: _marca()),
                          Expanded(flex: 2, child: _contacto()),
                          Expanded(flex: 2, child: _informacion()),
                          Expanded(flex: 3, child: _ubicacion()),
                        ],
                      ),

                const SizedBox(height: 45),

                Container(height: 1, color: Colors.white24),

                const SizedBox(height: 20),

                /// FOOTER INFERIOR
                Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 16,
                      runSpacing: 8,
                      children: const [
                        Text(
                          '© 2026 Todos los derechos reservados.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Sitio desarrollado por Justin León Pérez.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          color: Colors.white54,
                          size: 18,
                        ),

                        InkWell(
                          onTap: () async {
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: 'justinleon1111@gmail.com',
                              query:
                                  'subject=Hola Justin&body=Me interesa una página web',
                            );

                            await launchUrl(emailLaunchUri);
                          },
                          child: const Text(
                            'justinleon1111@gmail.com',
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titulo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _item(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 15,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _marca() {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/imagenes/logo-accesoriosGonzales-fondoBlanco.png',
            height: 180,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 18),

          const Text(
            'Tu tienda confiable en accesorios,\nrepuestos y productos de calidad.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
          ),

          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _red(FontAwesomeIcons.facebookF),
              _red(FontAwesomeIcons.instagram),
              _red(FontAwesomeIcons.tiktok),
              _red(FontAwesomeIcons.whatsapp),
            ],
          ),
        ],
      ),
    );
  }

  Widget _red(IconData icono) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
      ),
      child: Center(child: FaIcon(icono, color: Colors.white, size: 18)),
    );
  }

  Widget _contacto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titulo('Contacto'),

        _itemIcono(FontAwesomeIcons.phone, '+506 8514 3464'),

        _itemIcono(FontAwesomeIcons.whatsapp, '+506 8514 3464'),

        _itemIcono(FontAwesomeIcons.envelope, 'ventas@accesorios.com'),

        _itemIcono(FontAwesomeIcons.locationDot, 'Limón, Costa Rica'),

        const SizedBox(height: 18),

        OutlinedButton.icon(
          onPressed: abrirMaps,
          icon: const Icon(Icons.map_outlined, color: Colors.white, size: 18),
          label: const Text(
            'Abrir en Maps',
            style: TextStyle(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white24),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemIcono(IconData icono, String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(icono, size: 16, color: Colors.white70),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              texto,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _informacion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titulo('Nosotros'),
        _item('Sobre nosotros'),
        _item('Misión'),
        _item('Visión'),
        _item('Nuestros valores'),
        _item('Compromiso con el cliente'),
      ],
    );
  }

  Widget _ubicacion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titulo('Ubicación'),

        _item('Guapiles, Costa Rica'),

        const SizedBox(height: 12),

        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: SizedBox(
            height: 220,
            width: double.infinity,
            child: HtmlWidget('''
<iframe
src="https://www.google.com/maps?q=9.9800031,-83.0785235&z=17&output=embed"
width="100%"
height="100%"
style="border:0;"
loading="lazy">
</iframe>
'''),
          ),
        ),
      ],
    );
  }

  Future<void> abrirMaps() async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=9.9800031,-83.0785235',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
