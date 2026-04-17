import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tienda_motos/widgets/categoria_item.dart';
import 'package:tienda_motos/widgets/general_components/categoria_section.dart';
import 'package:tienda_motos/widgets/general_components/promo_section.dart';

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

    return ScrollConfiguration(
      // 👇 FIX PRINCIPAL: habilita mouse drag en web/desktop para TODA la página
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                CategoriaSection(
                  titulo: 'Nuestras Categorías',
                  items: categorias,
                  itemBuilder: (c) => CategoriaItem(
                    nombre: c['nombre'] as String,
                    icono: c['icono'] as IconData,
                    activa: (c['activa'] as bool?) ?? false,
                  ),
                ),

                const SizedBox(height: 40),

                PromoSection(items: promociones),

                const SizedBox(height: 40),

                _ProductosSection(),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      alignment: Alignment.center,
      child: const Text(
        'Aquí irá un banner (slider)',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class _ProductosSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LOS MÁS BUSCADOS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E478D),
          ),
        ),

        const SizedBox(height: 20),

        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
          ),
          alignment: Alignment.center,
          child: const Text('Aquí irá el grid de productos'),
        ),
      ],
    );
  }
}
