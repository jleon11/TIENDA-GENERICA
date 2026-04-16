import 'package:flutter/material.dart';

class _GaleriaModal extends StatefulWidget {
  final List<String> imagenes;
  final int indexInicial;

  const _GaleriaModal({required this.imagenes, required this.indexInicial});

  @override
  State<_GaleriaModal> createState() => _GaleriaModalState();
}

class _GaleriaModalState extends State<_GaleriaModal> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.indexInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(40),
      child: Stack(
        children: [
          /// CONTENEDOR PRINCIPAL
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// IMAGEN GRANDE
                SizedBox(
                  height: 400,
                  child: InteractiveViewer(
                    child: Image.network(
                      widget.imagenes[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// TEXTO ABAJO
                Text(
                  'Imagen ${index + 1} de ${widget.imagenes.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          /// BOTÓN CERRAR
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.close, size: 28),
              color: Colors.black,
              onPressed: () => Navigator.pop(context),
            ),
          ),

          /// FLECHA IZQUIERDA
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_left, size: 40),
              color: Colors.black,
              onPressed: () {
                if (index > 0) {
                  setState(() => index--);
                }
              },
            ),
          ),

          /// FLECHA DERECHA
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_right, size: 40),
              color: Colors.black,
              onPressed: () {
                if (index < widget.imagenes.length - 1) {
                  setState(() => index++);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
