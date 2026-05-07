import 'package:flutter/material.dart';

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

  bool expandirInfoGeneral = true;

  bool expandirDescripcion = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final esMobile = width < 768;

    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        horizontal: esMobile ? 18 : 28,
        vertical: esMobile ? 18 : 26,
      ),

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

            child: tabActual == 0
                ? _buildInformacion(esMobile)
                : _buildInstalaciones(),
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

  Widget _buildInformacion(bool esMobile) {
    final infoGeneralTexto = widget.infoGeneral?.toString() ?? '';

    final descripcionTexto = widget.descripcion?.toString() ?? '';

    return Column(
      key: const ValueKey(0),

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        /// INFO GENERAL
        if (infoGeneralTexto.trim().isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              const Text(
                'Información General',

                style: TextStyle(
                  fontSize: 20,

                  fontWeight: FontWeight.w800,

                  color: Colors.black87,
                ),
              ),

              if (esMobile)
                _botonExpandir(
                  expandido: expandirInfoGeneral,

                  onTap: () {
                    setState(() {
                      expandirInfoGeneral = !expandirInfoGeneral;
                    });
                  },
                ),
            ],
          ),

          const SizedBox(height: 18),

          if (!esMobile || expandirInfoGeneral)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),

              child: Text(
                infoGeneralTexto,

                style: const TextStyle(
                  fontSize: 15,

                  height: 1.8,

                  color: Colors.black87,
                ),
              ),
            ),

          const SizedBox(height: 32),
        ],

        /// DESCRIPCION
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            const Text(
              'Descripción',

              style: TextStyle(
                fontSize: 20,

                fontWeight: FontWeight.w800,

                color: Colors.black87,
              ),
            ),

            if (esMobile)
              _botonExpandir(
                expandido: expandirDescripcion,

                onTap: () {
                  setState(() {
                    expandirDescripcion = !expandirDescripcion;
                  });
                },
              ),
          ],
        ),

        const SizedBox(height: 18),

        if (!esMobile || expandirDescripcion)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),

            child: Text(
              descripcionTexto,

              style: const TextStyle(
                fontSize: 15,

                height: 1.8,

                color: Colors.black87,
              ),
            ),
          ),
      ],
    );
  }

  Widget _botonExpandir({
    required bool expandido,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),

      onTap: onTap,

      child: AnimatedRotation(
        turns: expandido ? 0.5 : 0,

        duration: const Duration(milliseconds: 220),

        child: Container(
          padding: const EdgeInsets.all(6),

          decoration: BoxDecoration(
            color: Colors.grey.shade100,

            shape: BoxShape.circle,
          ),

          child: const Icon(
            Icons.keyboard_arrow_down_rounded,

            size: 24,

            color: Color(0xFF1E478D),
          ),
        ),
      ),
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
