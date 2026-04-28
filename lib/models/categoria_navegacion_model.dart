import 'package:tienda_motos/models/categoria_model.dart';

class CategoriaNavegacionModel {
  final CategoriaModel categoriaActiva;
  final List<CategoriaModel> categorias;

  const CategoriaNavegacionModel({
    required this.categoriaActiva,
    required this.categorias,
  });
}
