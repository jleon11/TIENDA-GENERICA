import 'package:flutter/material.dart';
import '../models/producto_model.dart';

class ProductoDetallePage extends StatelessWidget {
  final ProductoModel producto;

  const ProductoDetallePage({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
    final info =
        producto.informacionGeneral.toMap();

    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1100,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                /// ==========================
                /// BLOQUE PRINCIPAL
                /// ==========================
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    /// IMAGEN
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 420,
                        padding:
                            const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(
                                14,
                              ),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: Image.asset(
                          producto.cardImagen,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    const SizedBox(width: 32),

                    /// INFO DERECHA
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            producto.nombre,
                            style:
                                const TextStyle(
                                  fontSize: 28,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Text(
                            'Código: ${producto.codigo}',
                            style:
                                TextStyle(
                                  color: Colors
                                      .grey
                                      .shade700,
                                ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          if (producto
                              .mostrarDescuento)
                            Text(
                              '\$${producto.precioAnterior}',
                              style:
                                  const TextStyle(
                                    fontSize: 18,
                                    decoration:
                                        TextDecoration
                                            .lineThrough,
                                    color: Colors.grey,
                                  ),
                            ),

                          Text(
                            '\$${producto.precioActual}',
                            style:
                                const TextStyle(
                                  fontSize: 34,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Colors.green,
                                ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          Text(
                            producto.descripcion,
                            style:
                                const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          SizedBox(
                            width:
                                double.infinity,
                            height: 52,
                            child:
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons
                                        .shopping_cart,
                                  ),
                                  label: const Text(
                                    'Agregar al carrito',
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                /// ==========================
                /// INFORMACIÓN GENERAL
                /// ==========================
                const Text(
                  'Información general',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  child: Column(
                    children: info.entries.map((
                      item,
                    ) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                item.key,
                                style:
                                    const TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                              ),
                            ),

                            Expanded(
                              flex: 5,
                              child: Text(
                                item.value,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}