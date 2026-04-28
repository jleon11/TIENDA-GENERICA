import 'package:flutter/material.dart';

class GaleriaProductoWidget extends StatelessWidget {
  final List<String> imagenes;
  final int imagenSeleccionada;
  final ValueChanged<int> onImagenSeleccionada;

  const GaleriaProductoWidget({
    super.key,
    required this.imagenes,
    required this.imagenSeleccionada,
    required this.onImagenSeleccionada,
  });

  @override
  Widget build(BuildContext context) {
    final imagenesValidas = imagenes.where((e) => e.trim().isNotEmpty).toList();

    final bool tieneMultiplesImagenes = imagenesValidas.length > 1;

    /// índice seguro
    final int indexSeguro = imagenSeleccionada >= imagenesValidas.length
        ? 0
        : imagenSeleccionada;

    final String imagenActual = imagenesValidas.isNotEmpty
        ? imagenesValidas[indexSeguro]
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 560,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Imagen principal
              Padding(
                padding: const EdgeInsets.all(32),
                child: Image.network(
                  imagenActual,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    size: 90,
                    color: Colors.grey,
                  ),
                ),
              ),

              /// Flecha izquierda
              if (tieneMultiplesImagenes)
                Positioned(
                  left: 24,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      final anterior =
                          (indexSeguro - 1 + imagenesValidas.length) %
                          imagenesValidas.length;

                      onImagenSeleccionada(anterior);
                    },
                    child: _botonNavegacion(icono: Icons.chevron_left),
                  ),
                ),

              /// Flecha derecha
              if (tieneMultiplesImagenes)
                Positioned(
                  right: 24,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      final siguiente =
                          (indexSeguro + 1) % imagenesValidas.length;

                      onImagenSeleccionada(siguiente);
                    },
                    child: _botonNavegacion(icono: Icons.chevron_right),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        /// Miniaturas
        if (imagenesValidas.isNotEmpty)
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(imagenesValidas.length, (index) {
              final bool seleccionada = index == indexSeguro;

              return InkWell(
                onTap: () => onImagenSeleccionada(index),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: seleccionada
                          ? const Color(0xFF1E478D)
                          : Colors.grey.shade300,
                      width: seleccionada ? 2 : 1,
                    ),
                  ),
                  child: Image.network(
                    imagenesValidas[index],
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }),
          ),
      ],
    );
  }

  Widget _botonNavegacion({required IconData icono}) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icono, color: const Color(0xFF1E478D), size: 34),
    );
  }
}
