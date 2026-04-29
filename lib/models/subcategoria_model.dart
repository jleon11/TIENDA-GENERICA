import 'package:tienda_motos/models/categoria_model.dart';

class SubCategoriaModel {
  final String id;
  final String nombre;
  final String seoUrl;
  final bool activa;
  final int? orden;
  final String? descripcion;
  final String? icono;
  final CategoriaModel? categoria;

  const SubCategoriaModel({
    required this.id,
    required this.nombre,
    required this.seoUrl,
    this.activa = true,
    this.orden,
    this.descripcion,
    this.icono,
    this.categoria,
  });

  factory SubCategoriaModel.fromJson(Map<String, dynamic> item) {
    return SubCategoriaModel(
      id: item['id'].toString(),
      nombre: item['nombre'] ?? '',
      seoUrl: item['seoUrl'] ?? '',
      activa: item['activa'] ?? true,
      orden: item['orden'],
      descripcion: item['descripcion'],
      icono: item['icono'],
      categoria: item['categoria'] != null
          ? CategoriaModel.fromJson(item['categoria'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'seoUrl': seoUrl,
      'activa': activa,
      'orden': orden,
      'descripcion': descripcion,
      'icono': icono,
      'categoria': categoria?.toJson(),
    };
  }
}
