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

    final String imagenActual = imagenesValidas.isNotEmpty
        ? imagenesValidas[imagenSeleccionada]
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 560,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: imagenActual.isNotEmpty
                    ? Image.asset(imagenActual, fit: BoxFit.contain)
                    : const Icon(
                        Icons.image_not_supported_outlined,
                        size: 90,
                        color: Colors.grey,
                      ),
              ),

              if (tieneMultiplesImagenes)
                Positioned(
                  right: 24,
                  child: Container(
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
                    child: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF1E478D),
                      size: 34,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        if (imagenes.isNotEmpty)
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(imagenes.length, (index) {
              final bool seleccionada = index == imagenSeleccionada;

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
                  child: Image.asset(imagenes[index], fit: BoxFit.contain),
                ),
              );
            }),
          ),
      ],
    );
  }
}
