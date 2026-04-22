import 'package:flutter/material.dart';
import 'package:tienda_motos/models/producto_model.dart';

class CategoriaModel {
  final String id;
  final String nombre;
  final String ruta;
  final String? banner;
  final IconData? icono;

  final List<String> subcategorias;
  final List<ProductoModel> productos;

  const CategoriaModel({
    required this.id,
    required this.nombre,
    required this.ruta,
    this.banner,
    this.icono,
    this.subcategorias = const [],
    this.productos = const [],
  });
}
