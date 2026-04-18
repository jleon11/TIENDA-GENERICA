import 'package:flutter/material.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/widgets/galeria_producto.dart';
import 'package:tienda_motos/widgets/producto_detalle/info_general_producto.dart';
import 'package:tienda_motos/widgets/producto_detalle/panel_compra_producto.dart';

class ProductoDetallePage extends StatefulWidget {
  final ProductoModel producto;

  const ProductoDetallePage({super.key, required this.producto});

  @override
  State<ProductoDetallePage> createState() => _ProductoDetallePageState();
}

class _ProductoDetallePageState extends State<ProductoDetallePage> {
  int cantidad = 1;
  int imagenSeleccionada = 0;

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;

    final width = MediaQuery.of(context).size.width;
    final bool esMovil = width < 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: esMovil ? 16 : 32,
            vertical: 20,
          ),

          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  _buildBreadcrumb(producto),

                  const SizedBox(height: 24),

                  /// CONTENIDO PRINCIPAL
                  esMovil
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GaleriaProductoWidget(
                              imagenes: producto.imagenes,
                              imagenSeleccionada: imagenSeleccionada,
                              onImagenSeleccionada: (index) {
                                setState(() {
                                  imagenSeleccionada = index;
                                });
                              },
                            ),

                            const SizedBox(height: 28),

                            PanelCompraProductoWidget(
                              producto: producto,
                              cantidad: cantidad,
                              onSumar: _sumarCantidad,
                              onRestar: _restarCantidad,
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: GaleriaProductoWidget(
                                imagenes: producto.imagenes,
                                imagenSeleccionada: imagenSeleccionada,
                                onImagenSeleccionada: (index) {
                                  setState(() {
                                    imagenSeleccionada = index;
                                  });
                                },
                              ),
                            ),

                            const SizedBox(width: 48),

                            Expanded(
                              flex: 5,
                              child: PanelCompraProductoWidget(
                                producto: producto,
                                cantidad: cantidad,
                                onSumar: _sumarCantidad,
                                onRestar: _restarCantidad,
                              ),
                            ),
                          ],
                        ),

                  const SizedBox(height: 40),

                  /// INFO GENERAL
                  InfoGeneralProductoWidget(
                    descripcion: producto.descripcion,
                    infoGeneral: producto.informacionGeneral.toMap(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// BREADCRUMB
  Widget _buildBreadcrumb(ProductoModel producto) {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text(
          'Inicio',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1E478D),
            fontWeight: FontWeight.w600,
          ),
        ),

        const Icon(Icons.chevron_right, size: 18, color: Colors.grey),

        Text(
          producto.categoria,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1E478D),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _sumarCantidad() {
    if (cantidad < widget.producto.stock) {
      setState(() {
        cantidad++;
      });
    }
  }

  void _restarCantidad() {
    if (cantidad > 1) {
      setState(() {
        cantidad--;
      });
    }
  }
}
