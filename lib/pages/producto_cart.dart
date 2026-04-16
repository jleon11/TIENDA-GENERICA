import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/producto_model.dart';
import '../models/informacion_general_model.dart';

class ProductoCard<T extends InformacionGeneralModel> extends StatelessWidget {
  final ProductoModel<T> producto;

  const ProductoCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 IMAGEN (CLICKEABLE)
          GestureDetector(
            onTap: () {
              context.push('/DetalleProducto', extra: producto);
            },
            child: SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.network(producto.imagenes.first, fit: BoxFit.cover),
            ),
          ),

          /// 🔥 CONTENIDO
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NOMBRE
                Text(
                  producto.nombre,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 6),

                /// PRECIO
                Text(
                  '₡${producto.precio}',
                  style: const TextStyle(
                    color: Color(0xFF1E478D),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),

                /// BOTÓN
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Agregado: ${producto.nombre}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('Añadir al carrito'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
