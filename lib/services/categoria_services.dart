import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_motos/config/environment.dart';
import 'package:tienda_motos/models/categoria_model.dart';

class CategoriaService {
  final String _baseUrl = Environment.apiBaseUrl;

  Future<List<CategoriaModel>> obtenerCategorias() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/categorias?populate=*'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final lista = data['data'] as List<dynamic>? ?? [];

        return lista.map((item) => CategoriaModel.fromJson(item)).toList();
      }

      throw Exception('Error al cargar categorías (${response.statusCode})');
    } catch (e) {
      throw Exception('Error categorías: $e');
    }
  }

  Future<CategoriaModel?> obtenerCategoriaPorId(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/categorias/$id?populate=*'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return CategoriaModel.fromJson(data['data']);
      }

      return null;
    } catch (e) {
      throw Exception('Error categoría: $e');
    }
  }
}
