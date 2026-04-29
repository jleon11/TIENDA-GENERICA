import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_motos/config/environment.dart';
import 'package:tienda_motos/models/producto_model.dart';

class ProductoService {
  final String _baseUrl = Environment.apiBaseUrl;

  /// ==========================================
  /// Obtener todos los productos
  /// ==========================================
  Future<List<ProductoModel>> obtenerProductos() async {
    final List<ProductoModel> todos = [];
    int page = 1;
    bool hayMas = true;

    try {
      while (hayMas) {
        final response = await http.get(
          Uri.parse(
            '$_baseUrl/productos?populate=*&sort=createdAt:desc&pagination[page]=$page&pagination[pageSize]=25',
          ),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode != 200) {
          throw Exception('Error al cargar productos (${response.statusCode})');
        }

        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> lista = data['data'] as List<dynamic>? ?? [];
        final pagination = data['meta']?['pagination'];

        todos.addAll(lista.map((item) => ProductoModel.fromJson(item)));

        final int pageCount = pagination?['pageCount'] ?? page;
        hayMas = page < pageCount;
        page++;
      }

      return todos;
    } catch (e) {
      throw Exception('Error productos: $e');
    }
  }

  /// ==========================================
  /// Productos por categoría
  /// ==========================================

  /// ==========================================
  /// Productos por categoría padre (seoUrl)
  /// Ejemplo: hogar, automotriz, tecnologia
  /// ==========================================
  Future<List<ProductoModel>> productosPorCategoria(String seoUrl) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/productos'
          '?filters[sub_categoria][categoria][seoUrl][\$eq]=$seoUrl'
          '&populate[imagenes]=true'
          '&populate[sub_categoria][populate][categoria]=true'
          '&pagination[page]=1'
          '&pagination[pageSize]=3000',
        ),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final lista = data['data'] as List<dynamic>? ?? [];

        return lista.map((item) => ProductoModel.fromJson(item)).toList();
      }

      throw Exception(
        'Error al obtener productos por categoría (${response.statusCode})',
      );
    } catch (e) {
      throw Exception('Error productosPorCategoria: $e');
    }
  }
}
