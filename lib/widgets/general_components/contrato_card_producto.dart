import 'dart:ui';

mixin ContratoCardProducto {
  String get nombre;
  String get codigo;
  String get precioActual;
  String get cardImagen;
  String? get precioAnterior => null;
  bool get inventarioLimitado => false;
  String get cardEtiqueta => 'Exclusivo en línea';
  Color get cardColorEtiqueta => const Color(0xFF1E478D);
}
