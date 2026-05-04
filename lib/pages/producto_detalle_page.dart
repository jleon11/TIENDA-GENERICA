import 'package:flutter/material.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/models/subcategoria_model.dart';
import 'package:tienda_motos/sections/boletin_informativo_section.dart';
import 'package:tienda_motos/sections/footer_section.dart';
import 'package:tienda_motos/sections/product_grid_section.dart';
import 'package:tienda_motos/widgets/galeria_producto.dart';
import 'package:tienda_motos/widgets/producto_detalle/panel_compra_producto.dart';
import 'package:tienda_motos/widgets/producto_detalle/tabs_infoProducto_widget.dart';

class ProductoDetallePage extends StatefulWidget {
  final ProductoModel producto;
  final List<CategoriaModel> categoriasGlobales;

  const ProductoDetallePage({
    super.key,
    required this.producto,
    required this.categoriasGlobales,
  });

  @override
  State<ProductoDetallePage> createState() => _ProductoDetallePageState();
}

class _ProductoDetallePageState extends State<ProductoDetallePage> {
  int cantidad = 1;
  int imagenSeleccionada = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final masBuscados = [
    ProductoModel(
      id: '1',
      nombre: 'Camión LEGO Special Transport',
      descripcion: 'Producto destacado del catálogo.',
      precio: 24.99,
      precioAnteriorValor: 34.99,
      stock: 2,
      imagenes: ['assets/imagenes/masbuscado1.jpg'],
      subcategoria: SubCategoriaModel(
        id: 'cat1',
        nombre: 'Juguetes',
        seoUrl: 'juguetes',
      ),
      marca: 'LEGO',
      codigo: 'MB001',
      destacado: true,
      informacionGeneral: '',
    ),

    ProductoModel(
      id: '2',
      nombre: 'Consola Gamer X Pro + 2 Controles',
      descripcion: 'Consola gamer edición especial.',
      precio: 399.99,
      precioAnteriorValor: 459.99,
      stock: 2,
      imagenes: ['assets/imagenes/masbuscado2.jpg'],
      subcategoria: SubCategoriaModel(
        id: 'subcat1',
        nombre: 'Consolas',
        seoUrl: 'consolas',
      ),
      marca: 'X Pro',
      codigo: 'MB002',
      destacado: true,
      informacionGeneral: '',
    ),

    ProductoModel(
      id: '3',
      nombre: 'Tienda de Campaña McKinley 4 Personas',
      descripcion: 'Ideal para camping familiar.',
      precio: 89.99,
      precioAnteriorValor: 119.99,
      stock: 10,
      imagenes: ['assets/imagenes/masbuscado3.jpg'],
      subcategoria: SubCategoriaModel(
        id: 'subcat1',
        nombre: 'Tiendas',
        seoUrl: 'tiendas',
      ),
      marca: 'McKinley',
      codigo: 'MB003',
      informacionGeneral: '',
    ),

    ProductoModel(
      id: '4',
      nombre: 'Micrófonos Inalámbricos Profesionales',
      descripcion: 'Sistema profesional inalámbrico.',
      precio: 129.99,
      precioAnteriorValor: 159.99,
      stock: 2,
      imagenes: ['assets/imagenes/masbuscado4.jpg'],
      subcategoria: SubCategoriaModel(
        id: 'subcat1',
        nombre: 'Audio',
        seoUrl: 'audio',
      ),
      marca: 'Audio Pro',
      codigo: 'MB004',
      destacado: true,
      informacionGeneral: '',
    ),

    ProductoModel(
      id: '5',
      nombre: 'Adidas Urban White Edition',
      descripcion: 'Calzado urbano moderno.',
      precio: 74.99,
      precioAnteriorValor: 99.99,
      stock: 8,
      imagenes: ['assets/imagenes/masbuscado5.jpg'],
      subcategoria: SubCategoriaModel(
        id: 'subcat1',
        nombre: 'Juguetes',
        seoUrl: 'juguetes',
      ),
      marca: 'Adidas',
      codigo: 'MB005',
      informacionGeneral: '',
    ),

    ProductoModel(
      id: '6',
      nombre: 'Auto Clásico Mini Colección',
      descripcion: 'Coleccionable edición clásica.',
      precio: 14.99,
      precioAnteriorValor: 19.99,
      stock: 1,
      imagenes: ['assets/imagenes/masbuscado6.jpg'],
      subcategoria: SubCategoriaModel(
        id: 'subcat1',
        nombre: 'Juguetes',
        seoUrl: 'juguetes',
      ),
      marca: 'Mini Cars',
      codigo: 'MB006',
      destacado: true,
      informacionGeneral: '',
    ),

    ProductoModel(
      id: '7',
      nombre: 'Zapatos Formales Premium Black',
      descripcion: 'Zapato formal premium.',
      precio: 94.99,
      precioAnteriorValor: 129.99,
      stock: 9,
      imagenes: ['assets/imagenes/masbuscado7.jpg'],
      subcategoria: SubCategoriaModel(
        id: 'subcat1',
        nombre: 'Zapatos',
        seoUrl: 'zapatos',
      ),
      marca: 'Premium',
      codigo: 'MB007',
      informacionGeneral: '',
    ),

    ProductoModel(
      id: '8',
      nombre: 'Nike Kids Flex Runner',
      descripcion: 'Calzado infantil deportivo.',
      precio: 49.99,
      precioAnteriorValor: 59.99,
      stock: 2,
      imagenes: ['assets/imagenes/masbuscado8.jpg'],
      subcategoria: SubCategoriaModel(
        id: 'subcat1',
        nombre: 'Zapatos',
        seoUrl: 'zapatos',
      ),
      marca: 'Nike',
      codigo: 'MB008',
      destacado: true,
      informacionGeneral: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;

    final width = MediaQuery.of(context).size.width;
    final bool esMovil = width < 900;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              /// CONTENIDO PRINCIPAL CENTRADO
              Padding(
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
                        migajaDePan(producto),

                        const SizedBox(height: 24),

                        /// DETALLE PRODUCTO
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
                                    flex: 7,
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
                                    flex: 4,
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

                        /// TABS INFO
                        TabsInfoProductoWidget(
                          descripcion: producto.descripcion,
                          infoGeneral: producto.informacionGeneral,
                        ),

                        const SizedBox(height: 45),

                        /// MÁS PRODUCTOS
                        ProductGridSection<ProductoModel>(
                          titulo: 'MÁS PRODUCTOS PARA EXPLORAR',
                          items: masBuscados,
                          filas: 2,
                          anchoItem: 260,
                          alturaItem: 430,
                          espaciado: 8,
                          scrollController: _scrollController,
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),

              /// FULL WIDTH
              const BoletinInformativo(),

              const SizedBox(height: 5),

              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }

  /// BREADCRUMB
  Widget migajaDePan(ProductoModel producto) {
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
          producto.subcategoria?.nombre ?? 'Sin Subcategoría',
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
