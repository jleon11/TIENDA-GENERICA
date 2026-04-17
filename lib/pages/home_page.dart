import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/data/demo_producto.dart';
import 'package:tienda_motos/sections/product_grid_section.dart';
import 'package:tienda_motos/sections/categoria_section.dart';
import 'package:tienda_motos/sections/promo_section.dart';
import 'package:tienda_motos/widgets/categoria_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categorias = [
      {'nombre': 'Hogar', 'icono': Icons.home, 'activa': true},
      {'nombre': 'Accesorios', 'icono': Icons.extension},
      {'nombre': 'Electrónica', 'icono': Icons.memory},
      {'nombre': 'Herramientas', 'icono': Icons.build},
      {'nombre': 'Mantenimiento', 'icono': Icons.oil_barrel},
      {'nombre': 'Seguridad', 'icono': Icons.security},
    ];

    final promociones = [
      {
        'nombre': 'Smartwatch Black Edition',
        'sku': 'SW-001',
        'precioAnterior': '120000',
        'precioActual': '89900',
        'imagen': 'assets/imagenes/promo1.jpg',
      },
      {
        'nombre': 'Lentes de Sol Clásicos',
        'sku': 'GL-002',
        'precioAnterior': '45000',
        'precioActual': '29900',
        'imagen': 'assets/imagenes/promo2.jpg',
      },
      {
        'nombre': 'Mochila Outdoor Vinta',
        'sku': 'BP-003',
        'precioAnterior': '60000',
        'precioActual': '42900',
        'imagen': 'assets/imagenes/promo3.jpg',
      },
      {
        'nombre': 'Audífonos Inalámbricos Pro',
        'sku': 'HP-004',
        'precioAnterior': '85000',
        'precioActual': '64900',
        'imagen': 'assets/imagenes/promo4.jpg',
      },
      {
        'nombre': 'Mouse Inalámbrico Ergonómico',
        'sku': 'MS-005',
        'precioAnterior': '18000',
        'precioActual': '12900',
        'imagen': 'assets/imagenes/promo5.jpg',
      },
      {
        'nombre': 'Zapatillas Urban Style',
        'sku': 'SN-006',
        'precioAnterior': '95000',
        'precioActual': '69900',
        'imagen': 'assets/imagenes/promo6.jpg',
      },
      {
        'nombre': 'Cámara Instantánea Retro',
        'sku': 'CM-007',
        'precioAnterior': '110000',
        'precioActual': '79900',
        'imagen': 'assets/imagenes/promo7.jpg',
      },
      {
        'nombre': 'Control Remoto Drone DJI',
        'sku': 'DR-008',
        'precioAnterior': '150000',
        'precioActual': '119900',
        'imagen': 'assets/imagenes/promo8.jpg',
      },
      {
        'nombre': 'Figura Coleccionable Guerrero Anime',
        'sku': 'AN-009',
        'precioAnterior': '35000',
        'precioActual': '24900',
        'imagen': 'assets/imagenes/promo9.jpg',
      },
    ];

    final masBuscados = [
      DemoProducto(
        nombre: 'Camión LEGO Special Transport',
        codigo: 'MB001',
        precioActual: '24.99',
        precioAnterior: '34.99',
        cardImagen: 'assets/imagenes/masbuscado1.jpg',
        inventarioLimitado: true,
        cardEtiqueta: 'Más buscado',
        cardColorEtiqueta: const Color(0xFFE53935),
      ),
      DemoProducto(
        nombre: 'Consola Gamer X Pro + 2 Controles',
        codigo: 'MB002',
        precioActual: '399.99',
        precioAnterior: '459.99',
        cardImagen: 'assets/imagenes/masbuscado2.jpg',
        inventarioLimitado: true,
        cardEtiqueta: 'Oferta gamer',
        cardColorEtiqueta: const Color(0xFF43A047),
      ),
      DemoProducto(
        nombre: 'Tienda de Campaña McKinley 4 Personas',
        codigo: 'MB003',
        precioActual: '89.99',
        precioAnterior: '119.99',
        cardImagen: 'assets/imagenes/masbuscado3.jpg',
        inventarioLimitado: false,
        cardEtiqueta: 'Outdoor',
        cardColorEtiqueta: const Color(0xFF1E88E5),
      ),
      DemoProducto(
        nombre: 'Micrófonos Inalámbricos Profesionales',
        codigo: 'MB004',
        precioActual: '129.99',
        precioAnterior: '159.99',
        cardImagen: 'assets/imagenes/masbuscado4.jpg',
        inventarioLimitado: true,
        cardEtiqueta: 'Audio Pro',
        cardColorEtiqueta: const Color(0xFF6D4C41),
      ),
      DemoProducto(
        nombre: 'Adidas Urban White Edition',
        codigo: 'MB005',
        precioActual: '74.99',
        precioAnterior: '99.99',
        cardImagen: 'assets/imagenes/masbuscado5.jpg',
        inventarioLimitado: false,
        cardEtiqueta: 'Nuevo ingreso',
        cardColorEtiqueta: const Color(0xFF3949AB),
      ),
      DemoProducto(
        nombre: 'Auto Clásico Mini Colección',
        codigo: 'MB006',
        precioActual: '14.99',
        precioAnterior: '19.99',
        cardImagen: 'assets/imagenes/masbuscado6.jpg',
        inventarioLimitado: true,
        cardEtiqueta: 'Coleccionable',
        cardColorEtiqueta: const Color(0xFF00897B),
      ),
      DemoProducto(
        nombre: 'Zapatos Formales Premium Black',
        codigo: 'MB007',
        precioActual: '94.99',
        precioAnterior: '129.99',
        cardImagen: 'assets/imagenes/masbuscado7.jpg',
        inventarioLimitado: false,
        cardEtiqueta: 'Elegancia',
        cardColorEtiqueta: const Color(0xFF212121),
      ),
      DemoProducto(
        nombre: 'Nike Kids Flex Runner',
        codigo: 'MB008',
        precioActual: '49.99',
        precioAnterior: '59.99',
        cardImagen: 'assets/imagenes/masbuscado8.jpg',
        inventarioLimitado: true,
        cardEtiqueta: 'Infantil',
        cardColorEtiqueta: const Color(0xFF000000),
      ),
    ];

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: SistemaConstantes.anchoMaximoContenido,
            ),
            child: Padding(
              padding: SistemaConstantes.paddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  CategoriaSection(
                    titulo: 'NUESTRAS CATEGORÍAS',
                    items: categorias,
                    itemBuilder: (c) => CategoriaItem(
                      nombre: c['nombre'] as String,
                      icono: c['icono'] as IconData,
                      activa: (c['activa'] as bool?) ?? false,
                    ),
                  ),

                  const SizedBox(height: SistemaConstantes.espacioSeccion),

                  PromoSection(
                    titulo: 'PROMO DEL MES',
                    items: promociones,
                    badgeTexto: 'Promo del mes',
                    badgeColor: Colors.red,
                  ),

                  const SizedBox(height: SistemaConstantes.espacioSeccion),

                  ProductGridSection<DemoProducto>(
                    titulo: 'LOS MÁS BUSCADOS',
                    items: masBuscados,
                    filas: 2,
                    anchoItem: 260,
                    alturaItem: 430,
                    espaciado: 8,
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
