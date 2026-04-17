import 'package:flutter/material.dart';
import 'package:tienda_motos/widgets/general_components/contrato_card_producto.dart';

class DemoProducto with ContratoCardProducto {
  @override
  final String nombre;

  @override
  final String codigo;

  @override
  final String precioActual;

  @override
  final String cardImagen;

  @override
  final String? precioAnterior;

  @override
  final bool inventarioLimitado;

  @override
  final String cardEtiqueta;

  @override
  final Color cardColorEtiqueta;

  DemoProducto({
    required this.nombre,
    required this.codigo,
    required this.precioActual,
    required this.cardImagen,
    this.precioAnterior,
    this.inventarioLimitado = false,
    this.cardEtiqueta = 'Exclusivo en línea',
    this.cardColorEtiqueta = const Color(0xFF1E478D),
  });
}
