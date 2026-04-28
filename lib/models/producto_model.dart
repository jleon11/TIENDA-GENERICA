import 'package:flutter/material.dart';
import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/widgets/general_components/contrato_card_producto.dart';

class ProductoModel implements ContratoCardProducto {
  /// ==========================================
  /// DATOS GENERALES DEL PRODUCTO
  /// ==========================================
  final String id;

  @override
  final String nombre;

  final String descripcion;

  /// Precio actual de venta
  final double precio;

  /// Precio anterior (para descuentos/ofertas)
  final double? precioAnteriorValor;

  /// Cantidad disponible
  final int stock;

  /// Imágenes del producto
  final List<String> imagenes;

  final CategoriaModel? categoria;

  final String marca;

  /// Código interno / SKU / referencia comercial
  @override
  final String codigo;

  final bool destacado;

  final bool activo;

  /// Información específica según tipo de producto

  final String informacionGeneral;

  final String mostrarEnlaSeccion;

  ProductoModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    this.precioAnteriorValor,
    required this.stock,
    required this.imagenes,
    required this.categoria,
    required this.marca,
    required this.codigo,
    required this.informacionGeneral,
    this.destacado = false,
    this.activo = true,
    this.mostrarEnlaSeccion = '',
  });

  /// ==========================================
  /// GETTERS DE NEGOCIO
  /// ==========================================

  /// Primera imagen disponible
  String get imagenPrincipal => imagenes.isNotEmpty ? imagenes.first : '';

  /// Indica si tiene descuento
  bool get enOferta =>
      precioAnteriorValor != null && precioAnteriorValor! > precio;

  /// Producto agotado
  bool get sinStock => stock <= 0;

  /// Dinero ahorrado
  double get ahorro =>
      precioAnteriorValor != null ? precioAnteriorValor! - precio : 0;

  /// ==========================================
  /// IMPLEMENTACIÓN DE ContratoCardProducto
  /// Requisitos mínimos para mostrarse en cards,
  /// grids, sliders, catálogo, etc.
  /// ==========================================

  @override
  String get precioActual => precio.toStringAsFixed(2);

  @override
  String? get precioAnterior => precioAnteriorValor?.toStringAsFixed(2);

  @override
  String get cardImagen => imagenPrincipal;

  @override
  bool get inventarioLimitado => stock <= 3 && stock > 0;

  @override
  String get cardEtiqueta => destacado ? 'Destacado' : '';

  @override
  Color get cardColorEtiqueta =>
      destacado ? const Color(0xFFE53935) : const Color(0xFF1E478D);

  @override
  bool get agotado => stock <= 0;

  @override
  bool get mostrarBotonCarrito => true; // Siempre mostrar botón de carrito, incluso sin stock (puede ser para notificar disponibilidad)

  @override
  bool get mostrarDescuento => enOferta;

  factory ProductoModel.fromJson(Map<String, dynamic> item) {
    final imagenesRaw = item['imagenes'] as List<dynamic>? ?? [];

    return ProductoModel(
      id: item['id'].toString(),
      nombre: item['nombre'] ?? '',
      descripcion: item['descripcion'] ?? '',
      precio: (item['precio'] ?? 0).toDouble(),

      precioAnteriorValor: item['precioAnteriorValor'] != null
          ? (item['precioAnteriorValor']).toDouble()
          : null,

      stock: item['stock'] ?? 0,

      imagenes: imagenesRaw.map<String>((img) {
        if (img is String) return img;
        return img['url'] ?? '';
      }).toList(),

      categoria: item['categorias'] != null
          ? CategoriaModel.fromJson(item['categorias'])
          : item['categoria'] != null
          ? CategoriaModel.fromJson(item['categoria'])
          : null,

      marca: item['marca'] ?? '',
      codigo: item['codigo'] ?? '',
      destacado: item['destacado'] ?? false,
      activo: item['activo'] ?? true,
      informacionGeneral: item['informacionGeneral'] ?? '',

      mostrarEnlaSeccion: item['mostrarEnlaSeccion'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'precioAnteriorValor': precioAnteriorValor,
      'stock': stock,
      'imagenes': imagenes,
      'categoria': categoria?.toJson(),
      'marca': marca,
      'codigo': codigo,
      'destacado': destacado,
      'activo': activo,
      'informacionGeneral': informacionGeneral,
      'mostrarEnlaSeccion': mostrarEnlaSeccion,
    };
  }
}
