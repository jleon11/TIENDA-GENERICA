import 'package:tienda_motos/models/producto_model.dart';

class CategoriaModel {
  final String id;
  final String nombre;
  final String seoUrl;
  final String? banner;
  //final IconData? icono;
  final String? icono;
  final List<String> subcategorias;
  final List<ProductoModel> productos;
  final int? orden;

  const CategoriaModel({
    required this.id,
    required this.nombre,
    required this.seoUrl,
    this.banner,
    this.icono,
    this.subcategorias = const [],
    this.productos = const [],
    this.orden,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> item) {
    return CategoriaModel(
      id: item['id'].toString(),
      nombre: item['nombre'] ?? '',
      seoUrl: item['seoUrl'] ?? '',
      banner: item['banner'],
      icono: item['icono'],
      orden: item['orden'],

      subcategorias: item['subcategorias'] != null
          ? List<String>.from(item['subcategorias'])
          : [],

      productos: item['productos'] != null
          ? (item['productos'] as List)
                .map((x) => ProductoModel.fromJson(x))
                .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'seoUrl': seoUrl,
      'banner': banner,
      'icono': icono,
      'orden': orden,
      'subcategorias': subcategorias,
      'productos': productos.map((x) => x.toJson()).toList(),
    };
  }
}
