import 'package:flutter/material.dart';
import 'package:tienda_motos/models/producto_model.dart';

class CarritoItem {
  final ProductoModel producto;
  int cantidad;

  CarritoItem({required this.producto, this.cantidad = 1});
}

class CarritoProvider extends ChangeNotifier {
  final List<CarritoItem> _items = [];

  List<CarritoItem> get items => List.unmodifiable(_items);

  int get totalItems => _items.fold(0, (sum, i) => sum + i.cantidad);

  double get totalPrecio =>
      _items.fold(0, (sum, i) => sum + (i.producto.precio * i.cantidad));

  void agregar(ProductoModel producto) {
    final index = _items.indexWhere((i) => i.producto.id == producto.id);

    if (index >= 0) {
      _items[index].cantidad++;
    } else {
      _items.add(CarritoItem(producto: producto));
    }

    notifyListeners();
  }

  void eliminar(String productoId) {
    _items.removeWhere((i) => i.producto.id == productoId);
    notifyListeners();
  }

  void decrementar(String productoId) {
    final index = _items.indexWhere((i) => i.producto.id == productoId);

    if (index >= 0) {
      if (_items[index].cantidad > 1) {
        _items[index].cantidad--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void limpiar() {
    _items.clear();
    notifyListeners();
  }
}
