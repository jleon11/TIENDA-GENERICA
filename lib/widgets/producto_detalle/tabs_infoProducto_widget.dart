import 'package:flutter/material.dart';

class TabsInfoProductoWidget extends StatefulWidget {
  final String descripcion;
  final Map<String, String> infoGeneral;
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
          /// Tabs Header
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

  /// ===============================
  /// TAB INFORMACIÓN
  /// ===============================
  Widget _buildInformacion() {
    return Column(
      key: const ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.infoGeneral.isNotEmpty)
          const Text(
            'Especificaciones',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),

        if (widget.infoGeneral.isNotEmpty) const SizedBox(height: 18),

        ...widget.infoGeneral.entries.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 170,
                  child: Text(
                    item.key,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                ),

                Expanded(
                  child: Text(
                    item.value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 26),

        const Text(
          'Descripción',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          widget.descripcion,
          style: const TextStyle(
            fontSize: 15,
            height: 1.8,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  /// ===============================
  /// TAB INSTALACIONES
  /// ===============================
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
