import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_motos/config/environment.dart';
import 'package:tienda_motos/models/subcategoria_model.dart';

class SubCategoriaService {
  final String _baseUrl = Environment.apiBaseUrl;

  Future<List<SubCategoriaModel>> obtenerTodasSubcategorias() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/sub-categorias'
          '?populate[categoria]=true'
          '&pagination[pageSize]=500',
        ),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Error obteniendo subcategorías (${response.statusCode})',
        );
      }

      final data = jsonDecode(response.body);

      final lista = data['data'] as List<dynamic>? ?? [];

      return lista.map((e) => SubCategoriaModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error obtenerTodasSubcategorias: $e');
    }
  }
}
