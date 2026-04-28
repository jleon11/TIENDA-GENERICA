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
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/productos?populate=*&sort=createdAt:desc'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final lista = data['data'] as List<dynamic>? ?? [];

        return lista.map((item) => ProductoModel.fromJson(item)).toList();
      }

      throw Exception('Error al cargar productos (${response.statusCode})');
    } catch (e) {
      throw Exception('Error productos: $e');
    }
  }

  /// ==========================================
  /// Obtener producto por ID
  /// ==========================================
  Future<ProductoModel?> obtenerProductoPorId(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/productos/$id?populate=*'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return ProductoModel.fromJson(data['data']);
      }

      return null;
    } catch (e) {
      throw Exception('Error producto: $e');
    }
  }

  /// ==========================================
  /// Productos destacados
  /// ==========================================
  Future<List<ProductoModel>> obtenerDestacados() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/productos?filters[destacado][\$eq]=true&populate=*',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final lista = data['data'] as List<dynamic>? ?? [];

        return lista.map((item) => ProductoModel.fromJson(item)).toList();
      }

      throw Exception('Error destacados (${response.statusCode})');
    } catch (e) {
      throw Exception('Error destacados: $e');
    }
  }

  /// ==========================================
  /// Buscar productos por nombre
  /// ==========================================
  Future<List<ProductoModel>> buscarProductos(String texto) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/productos?filters[nombre][\$containsi]=$texto&populate=*',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final lista = data['data'] as List<dynamic>? ?? [];

        return lista.map((item) => ProductoModel.fromJson(item)).toList();
      }

      throw Exception('Error búsqueda (${response.statusCode})');
    } catch (e) {
      throw Exception('Error búsqueda: $e');
    }
  }

  /// ==========================================
  /// Productos por categoría
  /// ==========================================
  Future<List<ProductoModel>> productosPorCategoria(String categoriaId) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/productos?filters[categorias][id][\$eq]=$categoriaId&populate=*',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final lista = data['data'] as List<dynamic>? ?? [];

        return lista.map((item) => ProductoModel.fromJson(item)).toList();
      }

      throw Exception('Error categoría (${response.statusCode})');
    } catch (e) {
      throw Exception('Error categoría: $e');
    }
  }
}
