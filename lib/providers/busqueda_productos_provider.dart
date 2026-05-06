import 'package:flutter/material.dart';

import 'package:tienda_motos/models/producto_model.dart';

class BusquedaProductosProvider extends ChangeNotifier {
  /// ==========================================
  /// TEXTO BUSQUEDA
  /// ==========================================
  String _textoBusqueda = '';

  String get textoBusqueda => _textoBusqueda;

  /// ==========================================
  /// RESULTADOS
  /// ==========================================
  List<ProductoModel> _resultados = [];

  List<ProductoModel> get resultados => _resultados;

  /// ==========================================
  /// MOSTRAR DROPDOWN
  /// ==========================================
  bool _mostrarResultados = false;

  bool get mostrarResultados => _mostrarResultados;

  /// ==========================================
  /// BUSCAR PRODUCTOS
  /// ==========================================
  void buscarProductos({
    required String texto,

    required List<ProductoModel> productos,
  }) {
    _textoBusqueda = texto;

    final textoLower = texto.toLowerCase().trim();

    /// ==========================================
    /// SI ESTA VACIO
    /// ==========================================
    if (textoLower.isEmpty) {
      _resultados = [];

      _mostrarResultados = false;

      notifyListeners();

      return;
    }

    /// ==========================================
    /// FILTRAR
    /// ==========================================
    _resultados = productos.where((p) {
      return p.nombre.toLowerCase().contains(textoLower) ||
          p.codigo.toLowerCase().contains(textoLower) ||
          p.marca.toLowerCase().contains(textoLower);
    }).toList();

    _mostrarResultados = true;

    notifyListeners();
  }

  /// ==========================================
  /// OCULTAR RESULTADOS
  /// ==========================================
  void ocultarResultados() {
    _mostrarResultados = false;

    notifyListeners();
  }

  /// ==========================================
  /// LIMPIAR
  /// ==========================================
  void limpiar() {
    _textoBusqueda = '';

    _resultados = [];

    _mostrarResultados = false;

    notifyListeners();
  }
}
