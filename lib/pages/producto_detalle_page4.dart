import 'package:flutter/material.dart';
import '../models/producto_model.dart';
import '../models/informacion_general_model.dart';

class ProductoDetallePage<T extends InformacionGeneralModel>
    extends StatefulWidget {
  final ProductoModel<T> producto;

  const ProductoDetallePage({super.key, required this.producto});

  @override
  State<ProductoDetallePage<T>> createState() => _ProductoDetallePageState<T>();
}

class _ProductoDetallePageState<T extends InformacionGeneralModel>
    extends State<ProductoDetallePage<T>> {
  int imagenSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;
    final info = producto.informacionGeneral.toMap();

    return Scaffold(
      appBar: AppBar(title: Text(producto.nombre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 GALERÍA
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  /// 👉 IMAGEN PRINCIPAL CON CLICK
                  GestureDetector(
                    onTap: () {
                      /*_abrirImagen(
                        context,
                        producto.imagenes[imagenSeleccionada],
                      );
                      */
                    },

                    child: Container(
                      height: 320,
                      color: Colors.grey.shade100,
                      child: Image.network(
                        producto.imagenes[imagenSeleccionada],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 👉 MINIATURAS
                  Row(
                    children: List.generate(producto.imagenes.length, (index) {
                      final img = producto.imagenes[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            imagenSeleccionada = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: imagenSeleccionada == index
                                  ? const Color(0xFF1E478D)
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Image.network(
                            img,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 30),

            /// 🔥 INFO
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '₡${producto.precio}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔥 BOTÓN
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: const Text('Añadir al carrito'),
                  ),

                  const SizedBox(height: 30),

                  /// 🔥 ESPECIFICACIONES
                  const Text(
                    'Especificaciones',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  ...info.entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text('• ${e.key}: ${e.value}'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirGaleria(BuildContext context, int indexInicial) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (_) {
        return const SizedBox.shrink();

        /*
        return _GaleriaModal(
          imagenes: widget.producto.imagenes,
          indexInicial: indexInicial,
        );*/
      },
    );
  }
}
