import 'dart:ui';

abstract class ContratoCardProducto {
  /// Datos mínimos para mostrar una card
  String get nombre;
  String get codigo;
  String get precioActual;
  String get cardImagen;

  /// Opcionales
  String? get precioAnterior;

  bool get mostrarDescuento;

  bool get mostrarBotonCarrito;

  bool get inventarioLimitado;

  bool get agotado;

  String get cardEtiqueta;

  Color get cardColorEtiqueta;
}
