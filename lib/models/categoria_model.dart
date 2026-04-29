class CategoriaModel {
  final String id;
  final String nombre;
  final String seoUrl;
  final String? banner;
  final String? icono;
  final int? orden;

  const CategoriaModel({
    required this.id,
    required this.nombre,
    required this.seoUrl,
    this.banner,
    this.icono,
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
    };
  }
}