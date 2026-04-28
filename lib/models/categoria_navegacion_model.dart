import 'package:tienda_motos/models/categoria_model.dart';
import 'package:tienda_motos/models/producto_model.dart';

class CategoriaNavegacionModel {
  final CategoriaModel categoriaActiva;
  final List<CategoriaModel> categorias;
  final List<ProductoModel> productos;

  const CategoriaNavegacionModel({
    required this.categoriaActiva,
    required this.categorias,
    required this.productos,
  });
}
