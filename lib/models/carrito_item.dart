import 'package:tienda_motos/models/informacion_general_model.dart';
import 'package:tienda_motos/models/producto_model.dart';

class CarritoItem<T extends InformacionGeneralModel> {
  final ProductoModel<T> producto;

  int cantidad;

  CarritoItem({required this.producto, this.cantidad = 1});

  double get subTotal => producto.precio * cantidad;
}
