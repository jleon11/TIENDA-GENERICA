import 'package:flutter/material.dart';
import 'package:tienda_motos/widgets/categoria_item.dart';
import 'package:tienda_motos/widgets/general_components/categoria_section.dart';
import 'package:tienda_motos/widgets/general_components/promo_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// 🔥 CATEGORÍAS OPTIMIZADAS (UI/UX)
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
        'nombre': 'FIGURA GOKU SUPER SAIYAJIN',
        'sku': 'FIG-DRAGON-001',
        'precioAnterior': '₡12,000 IVA Incluido',
        'precioActual': '₡9,990 IVA Incluido',
        'imagen': 'assets/imagenes/promo1.jpg',
      },
      {
        'nombre': 'CONTROL DJI ORIGINAL',
        'sku': 'DJI-CTRL-002',
        'precioAnterior': '₡45,000 IVA Incluido',
        'precioActual': '₡39,990 IVA Incluido',
        'imagen': 'assets/imagenes/promo2.jpg',
      },
      {
        'nombre': 'ZAPATILLA URBANA NIKE',
        'sku': 'NK-SHOE-003',
        'precioAnterior': '₡55,000 IVA Incluido',
        'precioActual': '₡44,990 IVA Incluido',
        'imagen': 'assets/imagenes/promo3.jpg',
      },
      {
        'nombre': 'CÁMARA POLAROID ORIGINAL',
        'sku': 'POL-600-004',
        'precioAnterior': '₡60,000 IVA Incluido',
        'precioActual': '₡49,990 IVA Incluido',
        'imagen': 'assets/imagenes/promo4.jpg',
      },
    ];

    return SingleChildScrollView(
      child: Center(
        /// 🔥 CONTENEDOR CENTRAL (CLAVE WEB)
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              /// 🔥 CATEGORÍAS
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

              /*
              /// 🔥 BANNER
              _BannerSection(),

              */
              const SizedBox(height: 40),

              /// 🔥 PRODUCTOS
              _ProductosSection(),

              const SizedBox(height: 80),
            ],
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
