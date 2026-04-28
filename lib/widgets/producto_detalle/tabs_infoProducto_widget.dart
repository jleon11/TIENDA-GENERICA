import 'package:flutter/material.dart';
import 'package:tienda_motos/widgets/general_components/rich_text_strapi_widget.dart';

class TabsInfoProductoWidget extends StatefulWidget {
  final dynamic descripcion;
  final dynamic infoGeneral;
  final String instalaciones;

  const TabsInfoProductoWidget({
    super.key,
    required this.descripcion,
    required this.infoGeneral,
    this.instalaciones = '',
  });

  @override
  State<TabsInfoProductoWidget> createState() => _TabsInfoProductoWidgetState();
}

class _TabsInfoProductoWidgetState extends State<TabsInfoProductoWidget> {
  int tabActual = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 28,
            runSpacing: 12,
            children: [
              _tab(titulo: 'Información del producto', index: 0),
              _tab(titulo: 'Instalaciones', index: 1),
            ],
          ),

          const SizedBox(height: 22),

          Divider(color: Colors.grey.shade200, height: 1),

          const SizedBox(height: 26),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: tabActual == 0 ? _buildInformacion() : _buildInstalaciones(),
          ),
        ],
      ),
    );
  }

  Widget _tab({required String titulo, required int index}) {
    final activo = tabActual == index;

    return InkWell(
      onTap: () {
        setState(() {
          tabActual = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: activo ? const Color(0xFF1E478D) : Colors.black54,
            ),
          ),

          const SizedBox(height: 8),

          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 2.5,
            width: activo ? 70 : 0,
            decoration: BoxDecoration(
              color: const Color(0xFF1E478D),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformacion() {
    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.infoGeneral != null) ...[
          const Text(
            'Información General',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 18),

          RichTextStrapiWidget(contenido: widget.infoGeneral),

          const SizedBox(height: 26),
        ],

        const Text(
          'Descripción',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 16),

        RichTextStrapiWidget(contenido: widget.descripcion),
      ],
    );
  }

  Widget _buildInstalaciones() {
    final texto = widget.instalaciones.trim().isEmpty
        ? '''
Compatibilidad revisada antes de instalar.

Utilice herramientas adecuadas.

Se recomienda instalación profesional para productos eléctricos o técnicos.

Verifique funcionamiento después de instalar.
'''
        : widget.instalaciones;

    final pasos = texto.split('\n').where((e) => e.trim().isNotEmpty).toList();

    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recomendaciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 18),

        ...pasos.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Icon(
                    Icons.check_circle,
                    size: 18,
                    color: Color(0xFF1E478D),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
