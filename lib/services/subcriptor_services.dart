import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tienda_motos/config/environment.dart';

class SubcriptorService {
  final String _baseUrl = Environment.apiBaseUrl;

  /// ==========================================
  /// Crear suscriptor
  /// ==========================================
  Future<void> crearSubcriptor({
    required String correo,
    String plataforma = 'web',
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/subcriptors'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'data': {
            'correo': correo.trim().toLowerCase(),
            'plataforma': plataforma,
          },
        }),
      );

      /// 201 = creado correctamente
      /// 400 = probablemente duplicado (unique)
      /// Ambos se consideran válidos visualmente
      if (response.statusCode != 201 && response.statusCode != 400) {
        throw Exception(
          'Error al registrar suscriptor: '
          '${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error crearSubcriptor: $e');
    }
  }
}
