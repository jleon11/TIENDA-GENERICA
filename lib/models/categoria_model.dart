import 'package:flutter/material.dart';

class CategoriaModel {
  final String nombre;
  final IconData icono;
  final bool activa;

  CategoriaModel({
    required this.nombre,
    required this.icono,
    this.activa = false,
  });
}
