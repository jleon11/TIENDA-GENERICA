import 'package:flutter/material.dart';
import 'package:tienda_motos/models/producto_model.dart';
import 'package:tienda_motos/providers/carrito_provider.dart';

class FavoritosProvider extends ChangeNotifier {
  final List<ProductoModel> _items = [];

  List<ProductoModel> get items => List.unmodifiable(_items);

  int get total => _items.length;

  bool esFavorito(String productoId) => _items.any((p) => p.id == productoId);

  void toggleFavorito(ProductoModel producto) {
    if (esFavorito(producto.id)) {
      _items.removeWhere((p) => p.id == producto.id);
    } else {
      _items.add(producto);
    }
    notifyListeners();
  }

  void enviarTodosAlCarrito(CarritoProvider carrito) {
    for (final producto in _items) {
      carrito.agregar(producto);
    }
    notifyListeners();
  }
}
