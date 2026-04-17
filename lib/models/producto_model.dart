import 'package:tienda_motos/models/informacion_general_model.dart';

class ProductoModel<T extends InformacionGeneralModel> {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final double? precioAnterior;
  final int stock;

  final List<String> imagenes;

  final String categoria;
  final String marca;
  final String sku;

  final bool destacado;
  final bool activo;

  final T informacionGeneral;

  ProductoModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    this.precioAnterior,
    required this.stock,
    required this.imagenes,
    required this.categoria,
    required this.marca,
    required this.sku,
    required this.informacionGeneral,
    this.destacado = false,
    this.activo = true,
  });

  String get imagenPrincipal => imagenes.isNotEmpty ? imagenes.first : '';

  bool get enOferta => precioAnterior != null && precioAnterior! > precio;
}
